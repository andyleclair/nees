defmodule Nees.Shapes.Square do
  defstruct [:origin, :size]
end

defimpl Nees.Shape, for: Nees.Shapes.Square do
  def draw(square) do
  end
end
