defmodule Nees.Shapes.Dot do
  @moduledoc """
  A Dot is just that, a lil spot at a point
  """
  defstruct [:point]
  alias Nees.Shapes.Dot

  defimpl Nees.Shape do
    def draw(%Dot{point: point}) do
      [
        "PU#{point}",
        "PD",
        "PU"
      ]
      |> Enum.join(";")
    end
  end
end
