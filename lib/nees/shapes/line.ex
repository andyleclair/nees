defmodule Nees.Shapes.Line do
  @moduledoc """
  A dang ol LINE
  """
  use Nees.Shapes.Shape

  typedstruct do
    field :start, Nees.point(), default: {0, 0}
    field :end, Nees.point(), default: {0, 0}
  end

  defimpl Nees.Shape do
    def draw(%Line{start: start, end: end_point}) do
      start |> pen_up() |> pen_down(end_point) |> pen_up()
    end
  end
end
