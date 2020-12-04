defmodule Nees.Sample.Circles3 do
  @moduledoc ~S"""
  Draws some circles in expanding rings
  """

  use Nees
  alias Nees.Shapes.Circle

  def main() do
    initial_size = 50
    draw_rings(initial_size)
  end

  def draw_rings(size) do
    if size >= Paper.xmax() || size >= Paper.ymax() do
      :ok
    else
      %Circle{center: Paper.center(), radius: size} |> Plotter.write()

      new_size = size + :rand.uniform(100) + 50

      draw_rings(new_size)
    end
  end
end
