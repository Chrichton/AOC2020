defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> count_trees_on_way()
  end

  def count_trees_on_way(map) do
    max_y = Enum.count(map) - 1

    count_trees_on_way_recursive(map, {0, 0}, max_y, 0)
  end

  def count_trees_on_way_recursive(_, {_, y}, max_y, acc) when y > max_y, do: acc

  def count_trees_on_way_recursive(map, position, max_y, acc) do
    if char_at_position(map, position) == "#",
      do: count_trees_on_way_recursive(map, next_position(position), max_y, acc + 1),
      else: count_trees_on_way_recursive(map, next_position(position), max_y, acc)
  end

  def next_position({x, y}), do: {x + 3, y + 1}

  def char_at_position(map, {x, y}) do
    max_x =
      Enum.at(map, 0)
      |> String.length()

    map
    |> Enum.at(y)
    |> String.at(rem(x, max_x))
  end
end
