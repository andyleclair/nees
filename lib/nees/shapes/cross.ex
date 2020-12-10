defmodule Nees.Shapes.Cross do
  @moduledoc """
  A Cross is an X at a certain point
  """
  defstruct [:start, :size]
  alias Nees.Shapes.Cross

  defimpl Nees.Shape do
    def draw(%Cross{start: start, size: size}) do
      [
        "PU#{start}",
        "PD#{start.x + size},#{start.y + size}",
        "PU#{start}",
        "PD#{start.x - size},#{start.y - size}",
        "PU#{start}",
        "PD#{start.x + size},#{start.y - size}",
        "PU#{start}",
        "PD#{start.x - size},#{start.y + size}"
      ]
      |> Enum.join(";")
    end
  end
end
