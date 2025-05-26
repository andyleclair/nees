defmodule Nees.Shapes.Hotspot do
  @moduledoc """
  A dot with a circle around it. Thanks for the name, Appcues!

  Radius means total outer radius. Gap is the size between the
  inner dot and the outer ring
  """
  use Nees.Shapes.Shape
  alias Nees.Shapes.Circle

  typedstruct do
    field :center, Nees.point(), default: {0, 0}
    field :radius, non_neg_integer(), default: 10
    field :gap, non_neg_integer(), default: 2
  end

  defimpl Nees.Shape do
    @doc "Circles are drawn from the center"
    def draw(%Hotspot{center: center, radius: radius, gap: gap}) do
      inner_radius = radius - gap

      [
        %Circle{center: center, radius: inner_radius, fill_style: 1},
        %Circle{center: center, radius: radius}
      ]
      |> Enum.map(&Nees.Shape.draw/1)
      |> Enum.join("")
    end
  end
end
