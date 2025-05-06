defmodule Nees.Sample.Text1 do
  @moduledoc ~S"""
  Draw some text of varying sizes
  """

  use Nees
  alias Nees.Shapes.Label
  @step 0.25
  @label "Hello world!"

  def main() do
    draw_text(nil, 1)
  end

  def draw_text(_, size) when size >= 5, do: :ok

  def draw_text(nil, size) do
    initial_label = %Label{
      text: @label,
      size: [
        width: size,
        height: size
      ]
    }

    :ok = initial_label |> Plotter.write()
    draw_text(initial_label, size + @step)
  end

  def draw_text(prev_label, size) do
    new_label = %Label{
      position: %Point{x: prev_label.position.x, y: prev_label.position.y + 500},
      text: @label,
      size: [
        width: size,
        height: size
      ]
    }

    :ok = new_label |> Plotter.write()
    draw_text(new_label, size + @step)
  end
end
