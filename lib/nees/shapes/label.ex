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
    def draw(%Label{position: position, size: size, text: text}) do
      position |> pen_up() |> text_size(size[:width], size[:height]) |> label(text) |> pen_up()
    end
  end
end
