defmodule Nees.Sample.RotatingSquares do
  @moduledoc """
  Draws a series of squares of increasing size with a
  pleasing rotation
  """
  use Nees

  def plot!() do
    shapes() |> Plotter.write()
  end

  def shapes() do
    for i <- 100..2500//100 do
      for theta <- 0..90//15 do
        %Square{origin: Paper.center(), size: i, rotation: theta}
      end
    end
  end
end
