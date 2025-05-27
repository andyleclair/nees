defmodule Nees.Sample.IncreasingSquares do
  @moduledoc """
  Draws a series of "squares" of increasing size
  """
  use Nees

  def plot!() do
    for i <- 100..2500//100 do
      not_square(Paper.center(), i, 0) |> Plotter.write() 
    end
  end

  # From my testing. Not a square, but looks cool!
  def not_square({x, y} = origin, size, rotation) do
    rot_rad = rotation * :math.pi() / 180
    p1 = {x + size * :math.cos(rot_rad), y + size * :math.sin(rot_rad)}
    p2 = {x - size * :math.sin(rot_rad), y + size * :math.cos(rot_rad)}
    p3 = {x - size * :math.cos(rot_rad), y - size * :math.sin(rot_rad)}
    p4 = {x + size * :math.sin(rot_rad), y - size * :math.cos(rot_rad)}
    "PU#{origin};PD#{p1},#{p2},#{p3},#{p4};PU;"
  end
end
  
