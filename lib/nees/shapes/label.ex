defmodule Nees.Shapes.Label do
  alias Nees.Point

  defstruct position: %Point{x: 0, y: 0},
            text: "",
            # {w, h} in mm. these are the defaults, cribbed from
            # https://www.isoplotec.co.jp/HPGL/eHPGL.htm#-SI(Absolute%20Character%20Size)
            size: [
              width: 0.285,
              height: 0.375
            ]

  defimpl Nees.Shape do
    def draw(text) do
      [
        "PU;PA#{text.position}",
        "SI#{text.size[:width]},#{text.size[:height]}",
        "LB#{text.text}#{<<3>>}",
        "PU"
      ]
      |> Enum.join(";")
    end
  end
end
