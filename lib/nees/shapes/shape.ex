defmodule Nees.Shapes.Shape do
  @moduledoc """
  Moduule for making defining shapes easier
  """

  defmacro __using__(_opts) do
    quote do
      use TypedStruct
      import Nees.HPGL
      alias __MODULE__
      alias Nees.Paper
    end
  end
end
