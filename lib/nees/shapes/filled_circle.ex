defmodule Nees.Shapes.FilledCircle do
  @moduledoc """
  Filltype can be 1 2 3 or 4
  """
  defstruct [:center, :radius, :fill_type]

  alias Nees.Shapes.FilledCircle

  defimpl Nees.Shape do
    @doc "Circles are drawn from the center"
    def draw(%FilledCircle{center: center, radius: radius, fill_type: fill_type}) do
      [
        "PU#{center}",
        "FT#{fill_type}",
        "WG#{radius},0,360",
        "PU"
      ]
      |> Enum.join(";")
    end
  end
end
