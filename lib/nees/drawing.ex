defmodule Nees.Drawing do
  alias Nees.{Command, Point}

  @spec line(%Point{}, %Point{}) :: Command.t()
  def line(from, to) do
    "PU#{from};PD;PA#{to};PU;"
  end
end
