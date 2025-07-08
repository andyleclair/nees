defmodule Nees.HPGL do
  @moduledoc """
  HPGL (Hewlett-Packard Graphics Language) is a vector graphics language used for printing and plotting. 
  This module provides functions to generate HPGL commands in the 7475a flavor
  """

  @doc """
  Initialize the plotter to default settings. This is the first command that should be sent to the plotter.

  When you boot the `Nees.Plotter` process, this will happen automatically.
  """
  def initialize() do
    "IN;SP1;\r\n"
  end

  @doc """
  Select a pen (1-6) for drawing. The default is pen 1.

  Selecting pen 0 will put the pen back into the carousel if there is an empty spot
  """
  def pen(index \\ 1)

  def pen(index) when index in 0..6 do
    "SP#{index};\r\n"
  end

  def pen(index) do
    raise "Invalid pen selection #{index}, only 6 pens in the carousel!"
  end

  def pen_up() do
    "PU;\r\n"
  end

  def pen_up({x, y}) do
    "PU#{x},#{y};\r\n"
  end

  def pen_down() do
    "PD;\r\n"
  end

  def pen_down({x, y}) do
    "PD#{x},#{y};\r\n"
  end

  def pen_down(points) when is_list(points) do
    Enum.reduce(points, nil, fn {x, y}, acc ->
      if is_nil(acc) do
        "PD#{x},#{y}"
      else
        acc <> "#{x},#{y}"
      end
    end) <> ";\r\n"
  end

  def move(x, y) do
    "PA#{x},#{y};\r\n"
  end
end
