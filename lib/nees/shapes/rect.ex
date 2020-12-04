defmodule Nees.Shapes.Rect do
  # Unfilled rects for now
  defstruct [:position, :width, :height]
end

defimpl Nees.Shape, for: Nees.Shapes.Rect do
  @doc """
  Absolute rectangles are drawn from start position (`position`)
  to the corner (`posn.x + width, posn.y + height`)
  """
  def draw(rect) do
    "PU#{rect.position};EA#{rect.position.x + rect.width},#{rect.position.y + rect.height}"
  end
end
