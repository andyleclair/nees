defmodule Nees.Shapes.Grass do
  @moduledoc """
  A blade of grass
  """
  use Nees.Shapes.Shape

  typedstruct do
    field :origin, Nees.Point, default: Paper.center()
    field :width, non_neg_integer(), default: 100
    field :height, non_neg_integer(), default: 200
  end

  defimpl Nees.Shape do
    def draw(%Grass{origin: origin, width: width}) do
      for i <- 1..width, reduce: pen_up(origin) do
        acc ->
          pen_down(
            acc,
            {i, i * i * i}
          )
      end
      |> pen_up()
    end
  end
end
