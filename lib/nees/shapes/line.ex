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
      [
        "PU#{start}",
        "PD#{end_point}",
        "PU"
      ]
      |> Enum.join(";")
    end
  end
end
