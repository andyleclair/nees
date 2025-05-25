defmodule Nees.Shapes.Circle do
  defstruct center: {0, 0}, radius: 10

  @type t() :: %__MODULE__{
          center: Nees.point(),
          radius: number()
        }

  defimpl Nees.Shape do
    @doc "Circles are drawn from the center"
    def draw(circle) do
      "PU#{circle.center};CI#{circle.radius};PU;"
    end
  end
end
