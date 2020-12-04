defmodule Nees.Drawing do
  @spec line(%Nees.Point{}, %Nees.Point{}) :: Nees.Command.t()
  def line(from, to) do
    "PU#{from};PD;PA#{to};PU;"
  end

  @spec circle(%Nees.Point{}, number()) :: Nees.Command.t()
  def circle(center, radius) do
    "PU#{center};CI#{radius};PU;"
  end

  @spec label(%Nees.Point{}, String.t()) :: Nees.Command.t()
  def label(start, text) do
    "PU#{start};LB#{text}#{<<3>>};PU;"
  end
end
