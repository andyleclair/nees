defmodule Nees.Sample.Grid do
  @moduledoc """
  A 10 x 10 grid of squares
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
        rotation: 0
      }
    end
  end

  def plot! do
    shape() |> Plotter.write()
  end
end
