defmodule Nees.Plotter do
  require Logger

  use GenServer
  alias Nerves.UART

  @device Application.get_env(:nees, :device, "ttyUSB0")
  @speed Application.get_env(:nees, :speed, 9600)

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec write(Nees.command()) :: :ok
  def write(code) do
    GenServer.call(__MODULE__, {:write, code}, :infinity)
  end

  @impl true
  def init(_) do
    {:ok, pid} = UART.start_link()

    case UART.open(pid, @device, speed: @speed, active: true) do
      :ok ->
        :ok = UART.write(pid, "IN;SP1;\r\n")
        write_buffer()
        {:ok, %{plotter: pid, buffer: []}}

      {:error, err} ->
        Logger.error("Error initializing the plotter: #{inspect(err)}")
        {:stop, "Error initializing plotter"}
    end
  end

  @impl true
  def handle_call({:write, code}, _from, %{buffer: buf} = state) do
    ended_code =
      if String.ends_with?(code, "\r\n") do
        code
      else
        code <> "\r\n"
      end

    new_buffer = buf ++ [ended_code]

    {:reply, :ok, %{state | buffer: new_buffer}}
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

  # TODO: handle pushback message when we fill the plotter's buffer

  def write_buffer() do
    Process.send_after(self(), :flush_line, 250)
  end
end
