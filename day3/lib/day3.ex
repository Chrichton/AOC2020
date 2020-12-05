defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  def solve1() do
    File.read!("testinput")
    |> String.split("\n")
    |> count_trees_on_way()
  end

  def count_trees_on_way(map, position \\ {0, 0}) do
    if char_at_position(map, position) == "#",
      do: 1 + count_trees_on_way(map, next_position(position)),
      else: count_trees_on_way(map, next_position(position))
  end

  def next_position({x, y}), do: {x + 3, y + 1}

  def char_at_position(map, {x, y}) do
    max_x =
      Enum.at(map, 0)
      |> String.length()
      |> Kernel.+(1)

    map
    |> Enum.at(y)
    |> String.at(rem(x, max_x))
  end
end
