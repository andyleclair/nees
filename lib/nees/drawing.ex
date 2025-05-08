defmodule Nees.Drawing do

  def line(from, to) do
    "PU#{from};PD;PA#{to};PU;"
  end

  def circle(center, radius) do
    "PU#{center};CI#{radius};PU;"
  end

  def label(start, text) do
    "DT$,1;PU#{start};LB#{text}$;PU;"
  end
end
