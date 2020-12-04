defmodule Nees.Sample.Rect1 do
  @moduledoc ~S"""
  Draws a line of rectangles, but on a sine wave!
  Much more interesting.
  """

  use Nees
  alias Nees.Shapes.Square
  @step 200
  @size 500

  def main() do
    start = %Point{x: 0, y: Paper.ymax() / 2}
    draw_squares(start)
  end

  def draw_squares(point) do
    case Paper.in_bounds?(point) do
      false ->
        :ok

      true ->
        %Square{origin: point, size: @size} |> Plotter.write()
        next_y = point.y + @step * :math.sin(point.x + @step)
        draw_squares(%Point{x: point.x + @step, y: next_y})
    end
  end
end
