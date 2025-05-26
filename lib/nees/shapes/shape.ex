defmodule Nees.Shapes.Shape do
  @moduledoc """
  Moduule for making defining shapes easier
  """

  defmacro __using__(_opts) do
    quote do
      use TypedStruct
      alias __MODULE__
    end
  end
end
