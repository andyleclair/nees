defmodule Nees.Shapes.Square do
  @moduledoc """
  Draws a square with the given origin and size.
  This draws a square with the center at `origin` a size of `size`, and a `rotation` in degrees.
  """
  use Nees.Shapes.Shape

  typedstruct do
    field :origin, Nees.point(), default: {0, 0}
    field :size, number(), default: 10
    field :rotation, number(), default: 0
  end

  defimpl Nees.Shape do
    def draw(%Square{origin: {x, y} = origin, size: size, rotation: rotation}) do
      rot_rad = rotation * :math.pi() / 180
      p1 = {x + size * :math.cos(rot_rad), y + size * :math.sin(rot_rad)}
      p2 = {x - size * :math.sin(rot_rad), y + size * :math.cos(rot_rad)}
      p3 = {x - size * :math.cos(rot_rad), y - size * :math.sin(rot_rad)}
      p4 = {x + size * :math.sin(rot_rad), y - size * :math.cos(rot_rad)}
      "PU#{origin};PD#{p1},#{p2},#{p3},#{p4};PU;"
    end
  end
end
