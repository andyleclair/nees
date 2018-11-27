defmodule Ness.Shapes.Rect do
  defstruct [:width, :height]
end

defimpl Ness.Shape, for: Ness.Shapes.Rect do
  def draw(rect) do
    ""
  end
end
