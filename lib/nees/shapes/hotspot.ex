defmodule Nees.Shapes.Hotspot do
  @moduledoc """
  A dot with a circle around it. Thanks for the name, Appcues!

  Radius means total outer radius. Gap is the size between the
  inner dot and the outer ring
  """
  defstruct [:center, :radius, :gap]

  alias Nees.Shapes.{FilledCircle, Circle, Hotspot}

  defimpl Nees.Shape do
    @doc "Circles are drawn from the center"
    def draw(%Hotspot{center: center, radius: radius, gap: gap}) do
      inner_radius = radius - gap

      [
        %FilledCircle{center: center, radius: inner_radius, fill_type: "1"},
        %Circle{center: center, radius: radius}
      ]
      |> Enum.map(&Nees.Shape.draw/1)
      |> Enum.join("")
    end
  end
end
