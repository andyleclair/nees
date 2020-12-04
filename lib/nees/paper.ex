defmodule Nees.Paper do
  alias Nees.Point

  def units_per_inch(), do: 1016
  def xmax(), do: trunc(11 * units_per_inch())
  def ymax(), do: trunc(8.5 * units_per_inch())

  def center() do
    %Point{x: xmax() / 2, y: ymax() / 2}
  end

  @spec in_bounds?(%Point{}) :: boolean
  def in_bounds?(point) do
    point.x <= xmax() && point.y <= ymax()
  end
end
