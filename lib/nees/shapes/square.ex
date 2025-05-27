defmodule Nees.Shapes.Square do
  @moduledoc """
  Draws a square with the given origin and size.
  This draws a square with the center at `origin` a size of `size`, and a `rotation` in degrees.
  """
  use Nees.Shapes.Shape
  import :math, only: [sin: 1, cos: 1]

  typedstruct do
    field :origin, Nees.point(), default: {0, 0}
    field :size, number(), default: 10
    field :rotation, number(), default: 0
  end

  defimpl Nees.Shape do
    def draw(%Square{origin: {x, y} = origin, size: size, rotation: rotation}) do
      rot_rad = rotation * :math.pi() / 180
      p1 = rotate(origin, x + size, y + size, rot_rad)
      p2 = rotate(origin, x - size, y + size, rot_rad)
      p3 = rotate(origin, x - size, y - size, rot_rad)
      p4 = rotate(origin, x + size, y - size, rot_rad)
      "PU#{p1};PD#{p2},#{p3},#{p4},#{p1};PU;"
    end

    # https://danceswithcode.net/engineeringnotes/rotations_in_2d/rotations_in_2d.html
    # x0 and y0 are the origin coords we are rotating around
    defp rotate({x0, y0}, x, y, rads) do
      st = sin(rads)
      ct = cos(rads)
      x1 = (x - x0) * ct - ((y - y0) * st) + x0
      y1 = (x - x0) * st + ((y - y0) * ct) + y0
      {
        Float.round(x1, 2),
        Float.round(y1, 2)
      }
    end
  end
end
