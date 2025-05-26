defmodule Nees.Shapes.Cross do
  @moduledoc """
  A Cross is an X at a certain point
  """
  use Nees.Shapes.Shape

  typedstruct do
    field :center, Nees.Point, default: {0, 0}
    field :size, non_neg_integer(), default: 10
  end

  defimpl Nees.Shape do
    def draw(%Cross{center: {x, y} = center, size: size}) do
      [
        "PU#{center}",
        "PD#{x + size},#{y + size}",
        "PU#{center}",
        "PD#{x - size},#{y - size}",
        "PU#{center}",
        "PD#{x + size},#{y - size}",
        "PU#{center}",
        "PD#{x - size},#{y + size}"
      ]
      |> Enum.join(";")
    end
  end
end
