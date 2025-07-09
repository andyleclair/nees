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
    field :buffer, Nees.program()
    field :status, :ready | :plotting | :awaiting_error | :awaiting_status | :errored
  end

  @device Application.compile_env(:nees, :device, "ttyUSB0")
  @speed Application.compile_env(:nees, :speed, 9600)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
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

  # TODO: allow for plotting to be started and stopped
  @impl true
  def init(opts) do
    {:ok, pid} = UART.start_link()

    with :ok <- UART.open(pid, @device, speed: @speed, active: true),
         _ <- Logger.debug("Initializing plotter..."),
         :ok <- UART.write(pid, HPGL.initialize()) do
      {:ok, %__MODULE__{plotter: pid, buffer: [], status: :ready}}
    else
      {:error, err} ->
        Logger.error("Error initializing the plotter: #{inspect(err)}")

        if opts[:require_started] do
          {:stop, "Error initializing plotter"}
        else
          Logger.debug("Plotter allowed to be off, continuing...")
          {:ok, %__MODULE__{plotter: pid, buffer: [], status: :ready}}
        end
    end
  end

  @impl true
  def handle_call({:write, code}, _from, %{buffer: buf} = state) when is_list(code) do
    # Enqueue writing to the plotter once we've appended the program to the state buffer
    GenServer.call(__MODULE__, :flush_line)
    {:reply, :ok, %{state | buffer: buf ++ List.flatten(code)}}
  end

  @impl true
  def handle_call(:get_error, _from, %{plotter: pid} = state) do
    UART.write(pid, "OE;\r\n")
    {:reply, :ok, %{state | status: :awaiting_error}}
  end

  @impl true
  def handle_info(:flush_line, %{buffer: buf, plotter: pid, status: :ready} = state) do
    case buf do
      [] ->
        {:noreply, state}

      [line | rest] ->
        # prepare_line appends OS; which will make the plotter send its' status back to us.
        # as that is the final command, then we can wait until the plotter gets back to us to know that
        # its' buffer is empty and we can send another line. 
        UART.write(pid, prepare_line(line))
        {:noreply, %{state | buffer: rest, status: :awaiting_status}}
    end
  end

  def handle_info(:flush_line, state) do
    # If we aren't ready when we go to flush a line, wait a second
    Process.send_after(self(), :flush_line, 1000)
    {:noreply, state}
  end

  @impl true
  # Handling responses from the plotter
  def handle_info({:circuits_uart, _device, "0\r\n"}, %{status: :awaiting_error} = state) do
    Logger.debug("Recieved no error from plotter")
    {:noreply, %{state | status: :ready}}
  end

  def handle_info({:circuits_uart, _device, "1\r\n"}, %{status: :awaiting_error} = state) do
    Logger.error("Error code 1: unexpected command recieved")
    {:noreply, %{state | status: :ready}}
  end

  def handle_info({:circuits_uart, _device, "1\r\n"}, %{status: :awaiting_status} = state) do
    Logger.debug("Plotter currently plotting")
    {:noreply, %{state | status: :plotting}}
  end

  def handle_info({:circuits_uart, _device, "16\r\n"}, %{status: :awaiting_status} = state) do
    Logger.debug("Plotter ready to plot!")

    # if there's more to plot, plot it
    if state.buffer != [] do
      GenServer.call(__MODULE__, :flush_line)
    end

    {:noreply, %{state | status: :ready}}
  end

  def handle_info({:circuits_uart, _device, "24\r\n"}, %{status: :awaiting_status} = state) do
    Logger.debug("Plotter ready to plot!")

    # if there's more to plot, plot it
    if state.buffer != [] do
      GenServer.call(__MODULE__, :flush_line)
    end

    {:noreply, %{state | status: :ready}}
  end

  @impl true
  def handle_info({:circuits_uart, _device, code}, state) do
    Logger.debug("Got unhandled code from plotter: #{inspect(code)}")
    {:noreply, state}
  end

  defp prepare_line(code) do
    if String.ends_with?(code, "OS;\r\n") do
      code
    else
      code <> "OS;\r\n"
    end
  end
end
