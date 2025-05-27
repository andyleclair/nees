defmodule Nees.Sample.BoundingBox do
  @moduledoc """
  Draws a bounding box around the plottable area
  """
  use Nees

  def plot!() do
    %Line{start: {0, 0}, end: {0, Paper.ymax}} |> Plotter.write()
    %Line{start: {0, Paper.ymax()}, end: {Paper.xmax, Paper.ymax}} |> Plotter.write()
    %Line{start: {Paper.xmax, Paper.ymax()}, end: {Paper.xmax, 0}} |> Plotter.write()
    %Line{start: {Paper.xmax, 0}, end: {0, 0}} |> Plotter.write()
  end
  
end
