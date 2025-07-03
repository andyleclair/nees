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
      point |> pen_up() |> pen_down() |> pen_up()
    end
  end
end
