defmodule Nees do
  @moduledoc """
  Nees is a library for drawing on an HP 7475a pen plotter.
  """

  @type point :: {number(), number()}
  @type command :: String.t() | [String.t()]

  defmacro __using__(_opts) do
    quote do
      alias Nees.Plotter
      alias Nees.Paper
      alias Nees.Shapes.Circle
      alias Nees.Shapes.Cross
      alias Nees.Shapes.Dot
      alias Nees.Shapes.Label
      alias Nees.Shapes.Line
      alias Nees.Shapes.Square
    end
  end

  # Allow us to to_string a tuple directly for points
  defimpl String.Chars, for: Tuple do
    def to_string({x, y}) do
      "#{x},#{y}"
    end

    def to_string(_) do
      raise ArgumentError, "Cannot convert to string"
    end
  end
end
