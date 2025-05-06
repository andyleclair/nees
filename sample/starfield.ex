defmodule Nees.Sample.Starfield do
  use Nees

  alias Nees.Shapes.{Hotspot, Cross}

  @star_odds 0.000001

  def main() do
    Enum.each(1..Paper.xmax(), fn x ->
      Enum.each(1..Paper.ymax(), fn y ->
        rand = :random.uniform()

        if rand < @star_odds do
          IO.inspect(rand)

          if :random.uniform() < 0.5 do
            size = Enum.random(20..50)
            %Cross{start: %Point{x: x, y: y}, size: size} |> Plotter.write()
          else
            size = Enum.random(20..50)

            %Hotspot{center: %Point{x: x, y: y}, radius: size, gap: 15}
            |> Plotter.write()
          end
        end
      end)
    end)
  end
end
