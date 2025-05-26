defmodule Nees.Shapes.Label do
  @moduledoc """
  A Label is a text string at a position with a size.

  Size width and height are in mm. cribbed from
  https://www.isoplotec.co.jp/HPGL/eHPGL.htm#-SI(Absolute%20Character%20Size)
  """

  use Nees.Shapes.Shape

  typedstruct do
    field :position, Nees.point(), default: {0, 0}
    field :text, String.t(), default: ""
    field :size, Keyword.t(), default: [width: 0.285, height: 0.375]
  end

  defimpl Nees.Shape do
    def draw(text) do
      [
        "PU#{text.position}",
        "SI#{text.size[:width]},#{text.size[:height]}",
        "LB#{text.text}#{<<3>>}",
        "PU"
      ]
      |> Enum.join(";")
    end
  end
end
