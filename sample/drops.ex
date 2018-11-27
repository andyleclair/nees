defmodule Ness.Sample.Drops do
  @moduledoc ~S"""
  Shows off selecting pens while drawing.

  Assumes two different colors in carousel 5 and 6
  """

  use Ness

  def main() do
    initial_radius = 50
    draw_rings(initial_radius)
  end

  def draw_rings(radius) do
    if out_of_bounds(radius) do
      :ok
    else
      select_random_pen()

      Paper.center()
      |> circle(radius)
      |> Plotter.write()

      new_radius = radius + :rand.uniform(100) + 20

      draw_rings(new_radius)
    end
  end

  def select_random_pen() do
    Enum.random([5, 6]) |> Ness.Pen.pen() |> Plotter.write()
  end

  def out_of_bounds(radius) do
    diameter = radius * 2
    diameter >= Paper.xmax() || diameter >= Paper.ymax()
  end
end
