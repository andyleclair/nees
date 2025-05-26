defmodule Nees.Shapes.Dot do
  @moduledoc """
  A Dot is just that, a lil spot at a point
  """
  use Nees.Shapes.Shape

  typedstruct do
    field :point, Nees.point(), default: {0, 0}
  end

  defimpl Nees.Shape do
    def draw(%Dot{point: point}) do
      [
        "PU#{point}",
        "PD",
        "PU"
      ]
      |> Enum.join(";")
    end
  end
end
