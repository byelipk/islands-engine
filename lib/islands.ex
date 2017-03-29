defmodule IslandsEngine.Island do
  alias IslandsEngine.Coordinate, as: Coordinate

  def start_link() do
    Agent.start_link(fn -> [] end)
  end

  def coordinates(island) do
    Agent.get(island, fn state -> state end)
  end

  def forested?(island) do
    island
    |> coordinates
    |> Enum.all?(fn coord -> Coordinate.hit?(coord) == true end)
  end

  def replace_coordinates(island, new_coords) when is_list new_coords do
    Agent.update(island, fn(_state) -> new_coords end)
  end

  def to_string(island) do
    island_string =
      island
      |> coordinates
      |> Enum.reduce("", fn(coord, acc) -> "#{acc}, #{Coordinate.to_string(coord)}" end)

      "[" <> String.replace_leading(island_string, ", ", "") <> "]"
  end

end
