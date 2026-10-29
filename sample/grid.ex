defmodule Nees.Sample.Grid do
  @moduledoc """
  A 10 x 10 grid of squares
  """

  use Nees
  alias Nees.Shapes.Grid
  alias Nees.Shapes.Square

  @rows 10
  @columns 10
  @size floor(Paper.length() / 40)

  def shape do
    %Grid{
      rows: @rows,
      columns: @columns,
      center: Paper.center(),
      shape: Square,
      attrs: %{size: @size}
    }
  end

  def plot! do
    shape() |> Plotter.write()
  end
end
