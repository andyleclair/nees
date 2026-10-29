defmodule Nees.Shapes.Grid do
  @doc """
  A MxN grid of some shape
  """
  use Nees.Shapes.Shape
  alias Nees.Shapes.Square

  typedstruct do
    field :shape, atom(), enforce: true
    field :attrs, map(), default: %{}
    field :center, Nees.point(), default: Paper.center()
    field :width, integer()
    field :height, integer()
    field :rows, integer(), enforce: true
    field :columns, integer(), enforce: true
    field :scale, float(), default: 1.0
  end

  defimpl Nees.Shape do
    def draw(%Grid{
          shape: Square,
          center: {x0, y0},
          attrs: %{size: size},
          rows: rows,
          columns: columns
        }) do
      len = 2 * size
      origin_x = max(Paper.xmin(), x0 - columns / 2 * len)
      origin_y = max(Paper.ymin(), y0 - rows / 2 * len)

      for row <- 1..rows,
          column <- 1..columns do
        struct!(
          Square,
          %{
            size: size,
            origin: {
              (2 * row - 1) * size + origin_x,
              (2 * column - 1) * size + origin_y
            }
          }
        )
      end
    end
  end
end
