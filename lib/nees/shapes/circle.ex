defmodule Ness.Shapes.Circle do
  defstruct [:center, :radius]
end

defimpl Ness.Shape, for: Ness.Shapes.Circle do
  def draw(circle) do
    "PU#{circle.center};CI#{circle.radius};PU;"
  end
end
