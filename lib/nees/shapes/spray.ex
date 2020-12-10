defmodule Nees.Shapes.Spray do
  @moduledoc """
  A Spray is a start point and a number of spray lines
  The lines start from the start and radiate out in a direction
  and terminate in a little X thing
  """
  defstruct [:start, :length, :angle, :count]
  alias Nees.Shapes.{Cross, Line, Spray}

  defimpl Nees.Shape do
    @doc """
    Sprays are a compound shape
    """
    def draw(%Spray{start: start, length: length, angle: angle, count: count}) do
      ""
    end
  end
end
