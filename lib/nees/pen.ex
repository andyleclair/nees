defmodule Nees.Pen do
  @moduledoc ~S"""
  Selects a pen from the carousel
  """

  @spec pen(Integer) :: Nees.Command.t()
  def pen(index) when index <= 6 do
    "SP#{index};"
  end

  def pen(_index) do
    "SP1;"
  end
end
