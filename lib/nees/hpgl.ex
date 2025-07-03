defmodule Nees.HPGL do
  @moduledoc """
  HPGL (Hewlett-Packard Graphics Language) is a vector graphics language used for printing and plotting. 
  This module provides functions to generate HPGL commands in the 7475a flavor
  """

  @type command :: binary()
  @type program :: iodata()
  @type point :: Nees.point()

  @doc """
  Initialize the plotter to default settings. This is the first command that should be sent to the plotter.

  When you boot the `Nees.Plotter` process, this will happen automatically.
  """
  @spec initialize(program()) :: program()
  def initialize(program \\ []) do
    [program | "IN;"]
  end

  @doc """
  Select a pen (1-6) for drawing. The default is pen 1.

  Selecting pen 0 will put the pen back into the carousel if there is an empty spot
  """
  @spec pen(program(), non_neg_integer()) :: program()
  def pen(program \\ [], index \\ 1)

  def pen(program, index) when index in 0..6 do
    [program | "SP#{index};"]
  end

  def pen(_program, index) do
    raise "Invalid pen selection #{index}, only 6 pens in the carousel!"
  end

  @spec pen_up(program()) :: program()
  def pen_up(program) when is_list(program) do
    [program | "PU;"]
  end

  @spec pen_up(program(), point()) :: program()
  def pen_up(program \\ [], {x, y} = point) when is_list(program) and is_tuple(point) do
    [program | "PU#{x},#{y};"]
  end

  @spec pen_down(program()) :: program()
  def pen_down(program) when is_list(program) do
    [program | "PD;"]
  end

  @spec pen_down(program(), point() | [point()]) :: program()
  def pen_down(program \\ [], point_or_points)

  def pen_down(program, {x, y}) do
    [program | "PD#{x},#{y};"]
  end

  def pen_down(program, points) when is_list(program) and is_list(points) do
    program ++
      (Enum.reduce(points, nil, fn {x, y}, acc ->
         if is_nil(acc) do
           "PD#{x},#{y}"
         else
           acc <> "#{x},#{y}"
         end
       end) <> ";")
  end

  @spec move(iodata(), non_neg_integer(), non_neg_integer()) :: program()
  def move(program \\ [], x, y) do
    [program | "PA#{x},#{y};"]
  end

  @spec fill_type(program(), non_neg_integer()) :: program()
  def fill_type(program \\ [], fill_style)

  def fill_type(program, fill_style) when fill_style in 1..4 do
    [program | "FT#{fill_style};"]
  end

  def fill_type(_program, fill_style) do
    raise "Unsupported fill style: #{fill_style}. FT can only be 1-4"
  end

  @spec filled_circle(program(), non_neg_integer()) :: program()
  def filled_circle(program \\ [], radius) do
    [program | "WG#{radius},0,360;"]
  end

  @spec circle(program(), non_neg_integer()) :: program()
  def circle(program \\ [], radius) do
    [program | "WG#{radius},0,360;"]
  end

  def text_size(program \\ [], width, height) do
    [program | "SI#{width},#{height};"]
  end

  def label(program \\ [], text) do
    [program | "LB#{text}#{<<3>>};"]
  end
end
