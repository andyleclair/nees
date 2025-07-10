defmodule Nees.Sample.BoundingBox do
  @moduledoc """
  Draws a bounding box around the plottable area
  """
  use Nees

  import Paper

  def plot!() do
    %Line{start: {xmin(), ymin()}, end: {xmin(), ymax()}} |> Plotter.write()
    %Line{start: {xmin(), ymax()}, end: {xmax(), ymax()}} |> Plotter.write()
    %Line{start: {xmax(), ymax()}, end: {xmax(), ymin()}} |> Plotter.write()
    %Line{start: {xmax(), ymin()}, end: {xmin(), ymin()}} |> Plotter.write()
    %Line{start: {xmax() / 2, ymin()}, end: {xmax() / 2, ymax()}} |> Plotter.write()
    %Line{start: {xmin(), ymax() / 2}, end: {xmax() , ymax() /2 }} |> Plotter.write()
  end
  
end
