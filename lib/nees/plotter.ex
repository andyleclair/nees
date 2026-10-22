defmodule Nees.Plotter do
  @moduledoc """
  GenServer process to handle the connection to the plotter
  """
  require Logger

  use GenServer
  use TypedStruct
  alias Circuits.UART
  alias Nees.Shape
  alias Nees.HPGL

  typedstruct do
    field :plotter, pid()
    field :plot_buffer, Nees.program()
    field :output_buffer, binary()

    field :status,
          :ready
          | :plotting
          | :awaiting_error
          | :awaiting_status
          | :errored
          | :stopping
          | :stopped
  end

  @device Application.compile_env(:nees, :device, "ttyUSB0")
  @speed Application.compile_env(:nees, :speed, 9600)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def initialize do
    HPGL.initialize() |> write()
  end

  def write(code) when is_binary(code) do
    code |> List.wrap() |> write()
  end

  def write(shape) when is_struct(shape) do
    shape |> Shape.draw() |> write()
  end

  def write(code) when is_list(code) do
    GenServer.call(__MODULE__, {:write, code})
  end

  def get_error() do
    GenServer.call(__MODULE__, :get_error)
  end

  @doc """
  Stop the plotter and empty the plot buffer
  """
  def stop() do
    GenServer.call(__MODULE__, :stop_plotting)
  end

  @impl true
  def init(opts) do
    {:ok, pid} = UART.start_link()

    with :ok <- UART.open(pid, @device, speed: @speed, active: true),
         _ <- Logger.debug("Initializing plotter..."),
         :ok <- UART.write(pid, prepare_line(HPGL.initialize())) do
      {:ok, %__MODULE__{plotter: pid, plot_buffer: [], output_buffer: "", status: :ready}}
    else
      {:error, err} ->
        Logger.error("Error initializing the plotter: #{inspect(err)}")

        if opts[:require_started] do
          {:stop, "Error initializing plotter"}
        else
          Logger.debug("Plotter allowed to be off, continuing...")
          {:ok, %__MODULE__{plotter: pid, plot_buffer: [], output_buffer: "", status: :ready}}
        end
    end
  end

  @impl true
  def handle_call({:write, code}, _from, %{plot_buffer: buf} = state) when is_list(code) do
    processed = code |> draw_all() |> List.flatten()
    # Enqueue writing to the plotter once we've appended the program to the state buffer
    {:reply, :ok, %{state | plot_buffer: buf ++ processed}, {:continue, :plot}}
  end

  @impl true
  def handle_call(:get_error, _from, %{plotter: pid} = state) do
    UART.write(pid, "OE;\r\n")
    {:reply, :ok, %{state | status: :awaiting_error}}
  end

  @impl true
  def handle_call(:stop_plotting, _from, state) do
    {:reply, :ok, %{state | status: :stopping}}
  end

  @impl true
  def handle_continue(:plot, state) do
    case state.plot_buffer do
      [] ->
        {:noreply, state}

      [line | rest] ->
        # prepare_line appends OS; which will make the plotter send its' status back to us.
        # as that is the final command, then we can wait until the plotter gets back to us to know that
        # its' buffer is empty and we can send another line. 
        UART.write(state.plotter, prepare_line(line))
        {:noreply, %{state | plot_buffer: rest, status: :awaiting_status}}
    end
  end

  # TODO: buffer responses from the plotter bc we don't always get a full "\r\n" in one callback
  @impl true
  # Handling responses from the plotter

  def handle_info({:circuits_uart, _device, "0"}, %{status: :awaiting_error} = state) do
    Logger.debug("Recieved no error from plotter")
    {:noreply, %{state | status: :ready}}
  end

  def handle_info({:circuits_uart, _device, "1"}, %{status: :awaiting_error} = state) do
    Logger.error("Error code 1: unexpected command recieved")
    {:noreply, %{state | status: :ready}}
  end

  def handle_info({:circuits_uart, _device, status}, %{status: :awaiting_error} = state) do
    Logger.error("Error code #{status}")
    {:noreply, %{state | status: :ready}}
  end

  def handle_info({:circuits_uart, _device, <<128>>}, state) do
    Logger.debug("Plotter Turned on")
    {:noreply, %{state | plot_buffer: [HPGL.initialize()]}, {:continue, :plot}}
  end

  def handle_info({:circuits_uart, _device, <<255>>}, state) do
    Logger.debug("Plotter Turning Off")
    {:noreply, %{state | status: :stopping}}
  end

  def handle_info({:circuits_uart, _device, "1\r\n"}, state) do
    Logger.debug("Plotter currently plotting")
    {:noreply, %{state | status: :plotting}}
  end

  def handle_info({:circuits_uart, _device, "16\r\n"}, state) do
    maybe_keep_plotting(state)
  end

  # 17 is ready and pen down
  def handle_info({:circuits_uart, _device, "17\r\n"}, state) do
    maybe_keep_plotting(state)
  end

  def handle_info({:circuits_uart, _device, "24\r\n"}, state) do
    maybe_keep_plotting(state)
  end

  def handle_info({:circuits_uart, _device, "24"}, %{status: :awaiting_status} = state) do
    Logger.debug("Plotter ready to plot!")

    maybe_keep_plotting(state)
  end

  def handle_info({:circuits_uart, _device, "32\r\n"}, %{status: :awaiting_status} = state) do
    Logger.debug("Plotter not ready, please put the arm down. Clearing buffer to be safe")

    {:noreply, %{state | plot_buffer: [], status: :ready}}
  end

  def handle_info({:circuits_uart, _device, "40\r\n"}, %{status: :awaiting_status} = state) do
    Logger.debug("Plotter not ready, please put the arm down. Clearing buffer to be safe")

    {:noreply, %{state | plot_buffer: [], status: :ready}}
  end

  def handle_info({:circuits_uart, _device, "48\r\n"}, %{status: :awaiting_status} = state) do
    Logger.debug("Error detected, Reading")

    UART.write(state.plotter, "OE;\r\n")
    {:noreply, %{state | status: :awaiting_error}}
  end

  def handle_info({:circuits_uart, _device, "49\r\n"}, %{status: :awaiting_status} = state) do
    Logger.debug("Error detected, Reading")

    UART.write(state.plotter, "OE;\r\n")
    {:noreply, %{state | status: :awaiting_error}}
  end

  def handle_info({:circuits_uart, _device, "\r\n"}, state) do
    maybe_keep_plotting(state)
  end

  def handle_info({:circuits_uart, _device, code}, state) do
    Logger.debug("Got unhandled code from plotter: #{inspect(code)}")
    maybe_keep_plotting(state)
  end

  defp maybe_keep_plotting(%{state: :stopping} = state) do
    Logger.debug("Plot stoppage requested!")
    {:noreply, %{state | status: :stopped, plot_buffer: []}}
  end

  defp maybe_keep_plotting(%{plot_buffer: buf} = state) when length(buf) > 0 do
    {:noreply, %{state | status: :ready}, {:continue, :plot}}
  end

  defp maybe_keep_plotting(state) do
    {:noreply, %{state | status: :ready}}
  end

  def draw_all([shape | rest]) when is_struct(shape) do
    [Shape.draw(shape) | draw_all(rest)]
  end

  def draw_all([code | rest]) when is_binary(code) do
    [code | draw_all(rest)]
  end

  def draw_all([list | rest]) when is_list(list) do
    Enum.map(list, &draw_all/1) ++ draw_all(rest)
  end

  def draw_all(shape) when is_struct(shape) do
    Shape.draw(shape)
  end

  def draw_all(bin) when is_binary(bin) do
    bin
  end

  def draw_all([]) do
    []
  end

  defp prepare_line(code) do
    if String.ends_with?(code, "OS;\r\n") do
      code
    else
      code <> "OS;\r\n"
    end
  end
end
