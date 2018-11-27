defmodule Nees.Shapes.Rect do
  defstruct [:width, :height]
end

defimpl Nees.Shape, for: Nees.Shapes.Rect do
  def draw(rect) do
    ""
  end
end
