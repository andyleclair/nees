# Nees

A library for interfacing with a HP 7475a pen plotter

Inspired by the great [Georg Nees](https://en.wikipedia.org/wiki/Georg_Nees)

## Notes

On Linux you may need to add yourself to the `dialout` group to access devices
in the `/dev/tty*` area. If nothing happens when you boot an `iex` shell,
that means the plotter hasn't been initialized and you should check this.

To _really_ make sure that's what it is, run this in `iex` (replacing "ttyUSB0" with your device)

```elixir
iex> Circuits.UART.enumerate() # This will list your available devices
iex> {:ok, pid} = Circuits.UART.start_link()
iex> Circuits.UART.open(pid, "ttyUSB0", speed: 9600, active: true)
```

If that returns `{:error, :eacces}` then you need to be in `dialout` (also log out and back in)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nees` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nees, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/nees](https://hexdocs.pm/nees).
