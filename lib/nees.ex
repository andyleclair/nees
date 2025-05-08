defmodule Nees do
  @moduledoc """
  Nees is a library for drawing on an HP 7475a pen plotter.
  """

  @type point :: {number(), number()}

  defmacro __using__(_opts) do
    quote do
      import Nees.Drawing
      alias Nees.Point
      alias Nees.Plotter
      alias Nees.Paper
    end
  end
end
