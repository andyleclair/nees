defmodule Nees.Command do
  @type t() :: String.t() | [String.t()]

  @spec initialize() :: t()
  def initialize() do
    "IN;SP1;"
  end
end
