defmodule Nees.Shapes.Line do
  @moduledoc """
  A dang ol LINE
  """
  defstruct [:start, :end]
  alias Nees.Shapes.Line

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
