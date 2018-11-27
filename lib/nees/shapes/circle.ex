defmodule Nees.Shapes.Circle do
  defstruct [:center, :radius]
end

defimpl Nees.Shape, for: Nees.Shapes.Circle do
  def draw(circle) do
    "PU#{circle.center};CI#{circle.radius};PU;"
  end
end
