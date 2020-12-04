defmodule Nees.Sample.Circles2 do
  @moduledoc ~S"""
  Draws a line of circles, but on a sine wave!
  Much more interesting.
  """

  use Nees
  @step 200
  @radius 500

  def main() do
    start = %Point{x: 0, y: Paper.ymax() / 2}
    draw_circles(start)
  end

  def draw_circles(point) do
    case Paper.in_bounds?(point) do
      false ->
        :ok

      true ->
        circle(point, @radius) |> Plotter.write()
        next_y = point.y + @step * :math.sin(point.x + @step)
        draw_circles(%Point{x: point.x + @step, y: next_y})
    end
  end
end
