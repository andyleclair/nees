defmodule Nees.Shapes.Square do
  @moduledoc """
  Draws a square with the given origin and size.
  This draws a square with the center at `origin` a size of `size`, and a `rotation` in degrees.
  """
  defstruct origin: {0, 0}, size: 10, rotation: 0

  @type t() :: %__MODULE__{
          origin: Nees.point(),
          size: number(),
          rotation: number()
        }

  defimpl Nees.Shape do
    def draw(square) do
      "PU#{square.origin};EA#{square.origin.x + square.size},#{square.origin.y + square.size}"
    end
  end
end
