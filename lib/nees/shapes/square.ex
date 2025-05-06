defmodule Nees.Shapes.Square do
  defstruct [:origin, :size]

  defimpl Nees.Shape do
    def draw(square) do
      "PU#{square.origin};EA#{square.origin.x + square.size},#{square.origin.y + square.size}"
    end
  end
end
