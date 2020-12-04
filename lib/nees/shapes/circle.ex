defmodule Nees.Shapes.Circle do
  defstruct [:center, :radius]

  defimpl Nees.Shape do
    @doc "Circles are drawn from the center"
    def draw(circle) do
      "PU#{circle.center};CI#{circle.radius};PU;"
    end
  end
end
