defmodule Nees.Paper do
  @moduledoc """
  The paper module defines the dimensions of the paper and provides functions to check if a point is within the bounds of the paper.

  The ranges here are for standard US A4 paper size, which is 8.5 x 11 inches.

  These numbers come from the HPGL 7475a manual.

  With the paper inserted in the plotter, (0, 0) is the bottom left corner of the paper, and (xmax, ymax) is the top right corner.
  However, there is a small border around the top, left, and right edges (not bottom!!) that the plotter cannot go outside of.

  There is a hard clip limit that keeps the plotter from going outside the paper. This is not a software limit, but a hardware limit. 
  The plotter will not go outside the paper, even if you tell it to.
  """

  def xmax(), do: 10_365
  def ymax(), do: 7962

  def center() do
    {xmax() / 2, ymax() / 2}
  end

  @spec in_bounds?(Nees.point()) :: boolean()
  def in_bounds?({x, y}) do
    x <= xmax() && y <= ymax()
  end
end
