defmodule Nees.Sample.Lines do
  use Nees

  def main() do
    start = Paper.center()
    draw_lines(start)
  end

  def draw_lines(start) do
    circle(start, 50) |> Plotter.write()
    draw_lines(start, next(), 1)
  end

  def draw_lines(_start, _end_pt, 50), do: :ok

  def draw_lines(start, end_pt, num) do
    circle(start, 50) |> Plotter.write()
    line(start, end_pt) |> Plotter.write()
    draw_lines(end_pt, next(), num + 1)
  end

  def next() do
    {:rand.uniform(Paper.xmax()), :rand.uniform(Paper.ymax())}
  end
end
