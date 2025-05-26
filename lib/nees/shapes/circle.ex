defmodule Nees.Shapes.Circle do
  @moduledoc """
  Draws a circle with a given center and radius.

  Fill style can be specified, but is not required.
  If not specified, the circle will be drawn as an outline.
  Fill style can be 1, 2, 3, or 4, which correspond to different fill patterns.
  """
  use Nees.Shapes.Shape

  typedstruct do
    field :center, Nees.point(), default: {0, 0}
    field :radius, non_neg_integer(), default: 10
    field :fill_style, non_neg_integer() | nil, default: nil
  end

  defimpl Nees.Shape do
    @doc "Circles are drawn from the center"
    def draw(%Circle{center: center, radius: radius, fill_style: fill_style}) do
      if fill_style do
        "PU#{center};FT#{fill_style};WG#{radius},0,360;PU;"
      else
        "PU#{center};CI#{radius};PU;"
      end
    end
  end
end
