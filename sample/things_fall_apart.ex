defmodule Nees.Sample.ThingsFallApart do
  @moduledoc """
  Based on the work by Georg Nees  
  """

  use Nees

  @rows 10
  @columns 10
  @size floor(Paper.length() / 10) / 2

  def shape do
    for row <- 1..@rows,
        column <- 1..@columns do
      %Square{
        origin: {
          (2 * row - 1) * @size + Paper.xmin(),
          (2 * column - 1) * @size + Paper.ymin()
        },
        size: @size,
        rotation: rotation(row)
      }
    end
  end

  def plot! do
    shape() |> Plotter.write()
  end

  def rotation(factor) do
    rot = :rand.uniform() * :rand.uniform(factor * factor)

    if :rand.uniform() < 0.5 do
      rot
    else
      -rot
    end
  end
end
