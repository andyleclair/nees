defmodule Nees.PlotterTest do
  use ExUnit.Case, async: true

  test "code with terminator is left alone" do
    assert("test\r\n" == Nees.Plotter.prepare_line("test\r\n"))
  end

  test "code without terminator is appended" do
    assert("test\r\n" == Nees.Plotter.prepare_line("test"))
  end
end
