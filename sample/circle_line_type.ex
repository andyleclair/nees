defmodule Nees.Sample.CircleLineType do
  @moduledoc """
  Draws a series of increasing sized circles with each line type
  """
  use Nees
  import Nees.HPGL

  def plot!() do
    shapes() |> Plotter.write()
  end

  def shapes() do
    for lt <- -1..6 do
      for size <- 100..700//100 do
        [
          line_type(lt),
          Nees.Shape.draw(%Circle{center: Paper.center(), radius: size})
        ]
      end
    end
  end
end
