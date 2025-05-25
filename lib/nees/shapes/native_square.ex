defmodule Nees.Shapes.NativeSquare do
  @moduledoc """
  Draws a square with the given origin and size.
  This uses the native HPGL square command, EA
  """
  defstruct [:origin, :size]

  defimpl Nees.Shape do
    def draw(square) do
      "PU#{square.origin};EA#{square.origin.x + square.size},#{square.origin.y + square.size}"
    end
  end
end
