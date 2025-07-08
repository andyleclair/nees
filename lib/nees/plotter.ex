defmodule Nees.Plotter do
  @moduledoc """
  GenServer process to handle the connection to the plotter
  """
  require Logger

  use GenServer
  alias Circuits.UART
  alias Nees.Shape
  alias Nees.HPGL

  @device Application.compile_env(:nees, :device, "ttyUSB0")
  @speed Application.compile_env(:nees, :speed, 9600)

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec write(Command.t() | Shape.t()) :: :ok
  def write(shape) when is_struct(shape) do
    shape |> Shape.draw() |> write()
  end

  def write(code) when is_binary(code) do
    GenServer.call(__MODULE__, {:write, code})
  end

  # TODO: allow for plotting to be started and stopped
  @impl true
  def init(_) do
    {:ok, pid} = UART.start_link()

    case UART.open(pid, @device, speed: @speed, active: true) do
      :ok ->
        Logger.debug("Initializing plotter...")

        :ok = UART.write(pid, prepare_line(HPGL.initialize()))

        write_buffer()

        {:ok, %{plotter: pid, buffer: []}}

      {:error, err} ->
        Logger.error("Error initializing the plotter: #{inspect(err)}")
        {:stop, "Error initializing plotter"}
    end
  end

  @impl true
  def handle_call({:write, code}, _from, %{buffer: buf} = state) when is_list(code) do
    {:reply, :ok, %{state | buffer: buf ++ code}}
  end

  @impl true
  def handle_call({:write, code}, _from, %{buffer: buf} = state) when is_binary(code) do
    {:reply, :ok, %{state | buffer: buf ++ [prepare_line(code)]}}
  end

  @impl true
  def handle_info(:flush_line, %{buffer: buf, plotter: pid} = state) do
    write_buffer()

    case buf do
      [] ->
        {:noreply, state}

      [line | rest] ->
        UART.write(pid, line)
        {:noreply, %{state | buffer: rest}}
    end
  end

  @impl true
  def handle_info({:circuits_uart, _device, <<6>>}, state) do
    Logger.error("Plotter turned off!")
    {:noreply, state}
  end

  @impl true
  def handle_info({:circuits_uart, _device, <<192>>}, state) do
    Logger.debug("Plotter turned on!")
    {:noreply, state}
  end

  # TODO: handle pushback message when we fill the plotter's buffer
  @impl true
  def handle_info({:circuits_uart, _device, code}, state) do
    Logger.debug("Got unhandled code from plotter: #{inspect(code, binaries: :as_binary)}")
    {:noreply, state}
  end

  def prepare_line(code) do
    if String.ends_with?(code, "\r\n") do
      code
    else
      code <> "\r\n"
    end
  end

  def write_buffer() do
    Process.send_after(self(), :flush_line, 250)
  end
end
