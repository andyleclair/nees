defmodule Nees.Sample.Circles do
  @moduledoc ~S"""
  Draws a line of circles. Neat, but sorta boring
  """

  use Nees
  alias Nees.Shapes.Circle
  @step 200
  @radius 500

  def main() do
    draw_circles(%Point{x: 0, y: Paper.ymax() / 2})
    :ok
  end

  def draw_circles(point) do
    if Paper.in_bounds?(point) do
      %Circle{center: point, radius: @radius} |> Plotter.write()
      draw_circles(%Point{x: point.x + @step, y: point.y})
    else
      :ok
    end
  end
end
