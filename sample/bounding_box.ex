defmodule Nees.Sample.BoundingBox do
  @moduledoc """
  Draws a bounding box around the plottable area
  """
  use Nees

  import Paper

  def plot!() do
    [
      %Line{start: {xmin(), ymin()}, end: {xmin(), ymax()}},
      %Line{start: {xmin(), ymax()}, end: {xmax(), ymax()}},
      %Line{start: {xmax(), ymax()}, end: {xmax(), ymin()}},
      %Line{start: {xmax(), ymin()}, end: {xmin(), ymin()}},
      %Line{start: {mid_x(), ymin()}, end: {mid_x(), ymax()}},
      %Line{start: {xmin(), mid_y()}, end: {xmax(), mid_y()}}
    ]
    |> Plotter.write()
  end
end
