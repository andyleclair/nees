defmodule Nees.Sample.Circles do
  @moduledoc ~S"""
  Draws a line of circles. Neat, but sorta boring
  """

  use Nees
  @step 200
  @radius 500

  def draw!() do
    draw_circles({0, Paper.ymax() / 2})
  end

  def draw_circles({x, y} = point) do
    if Paper.in_bounds?(point) do
      circle(point, @radius) |> Plotter.write()
      draw_circles({x + @step, y})
    else
      :ok
    end
  end
end
