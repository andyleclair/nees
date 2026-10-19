defmodule Nees.Shapes.Arc do
  @moduledoc """
  Draws an arc with a given center and radius.
  """
  use Nees.Shapes.Shape

  typedstruct do
    field :center, Nees.point(), default: {0, 0}
    field :radius, non_neg_integer(), default: 10
  end

  # defimpl Nees.Shape do
  #   @doc "Arcs are drawn relative from the center"
  #   def draw(%Arc{center: center, radius: radius}) do
  #     center
  #     |> pen_up()
  #     |> arc(radius)
  #     |> pen_up()
  #   end
  # end
end
