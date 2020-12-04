defmodule Nees.Shapes.Square do
  defstruct [:origin, :size]
end

defimpl Nees.Shape, for: Nees.Shapes.Square do
  def draw(square) do
    "PU#{square.origin};EA#{square.origin.x + square.size},#{square.origin.y + square.size}"
  end
end
