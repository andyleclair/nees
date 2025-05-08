defmodule Nees.Sample.Circles2 do
  @moduledoc ~S"""
  Draws a line of circles, but on a sine wave!
  Much more interesting.
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
      next_y = y + @step * :math.sin(x + @step)
      draw_circles({x + @step, y: next_y})
    else
      :ok
    end
  end
end
