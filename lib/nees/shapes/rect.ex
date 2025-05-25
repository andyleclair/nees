defmodule Nees.Shapes.Rect do
  @moduledoc """
  Absolute rectangles are drawn from start position (`position`)
  to the corner (`posn.x + width, posn.y + height`)
  """
  # Unfilled rects for now
  defstruct position: {0, 0}, width: 10, height: 10

  defimpl Nees.Shape do
    def draw(rect) do
      "PU#{rect.position};EA#{rect.position.x + rect.width},#{rect.position.y + rect.height}"
    end
  end
end
