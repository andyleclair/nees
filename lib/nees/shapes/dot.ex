defmodule Nees.Shapes.Dot do
  @moduledoc """
  A Dot is just that, a lil spot at a point
  """
  defstruct point: {0, 0}

  @type t() :: %__MODULE__{
          point: Nees.point()
        }
  alias __MODULE__

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
