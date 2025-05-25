defmodule Nees do
  @moduledoc """
  Nees is a library for drawing on an HP 7475a pen plotter.
  """

  @type point :: {number(), number()}

  defmacro __using__(_opts) do
    quote do
      alias Nees.Plotter
      alias Nees.Paper
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
