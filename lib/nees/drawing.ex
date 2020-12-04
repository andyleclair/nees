defmodule Nees.Drawing do
  alias Nees.{Command, Point}

  @spec line(%Point{}, %Nees.Point{}) :: Command.t()
  def line(from, to) do
    "PU#{from};PD;PA#{to};PU;"
  end

  @spec circle(%Point{}, number()) :: Command.t()
  def circle(center, radius) do
    "PU#{center};CI#{radius};PU;"
  end

  @spec label(%Point{}, String.t()) :: Command.t()
  def label(start, text) do
    "PU#{start};LB#{text}#{<<3>>};PU;"
  end
end
