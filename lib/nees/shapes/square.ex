defmodule Ness.Shapes.Square do
  defstruct [:origin, :size]
end

defimpl Ness.Shape, for: Ness.Shapes.Square do
  def draw(square) do
  end
end
