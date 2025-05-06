defmodule Nees.Command do
  @type t() :: String.t()

  @spec initialize() :: Nees.Command.t()
  def initialize() do
    "IN;SP1;"
  end
end
