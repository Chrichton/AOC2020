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

    count_trees_on_way_recursive(map, next_position(), {0, 0}, max_y, 0)
  end

  def count_trees_on_way_recursive(_, _, {_, y}, max_y, acc) when y > max_y, do: acc

  def count_trees_on_way_recursive(map, next_position_func, position, max_y, acc) do
    acc = if is_tree_at_position(map, position), do: acc + 1, else: acc

    count_trees_on_way_recursive(
      map,
      next_position_func,
      next_position_func.(position),
      max_y,
      acc
    )
  end

  def next_position(), do: fn {x, y} -> {x + 3, y + 1} end

  def is_tree_at_position(map, position), do: char_at_position(map, position) == "#"

  def char_at_position(map, {x, y}) do
    max_x =
      Enum.at(map, 0)
      |> String.length()

    map
    |> Enum.at(y)
    |> String.at(rem(x, max_x))
  end

  # --------------

  #   def solve2() do
  #     File.read!("input")
  #     |> String.split("\n")
  #     |> count_trees_on_way_second_star()
  #   end

  #   def count_trees_on_way_second_star(map) do

  #   end

  #   def next_positions({x, y}), do: [{x + 1, y + 1}, {x + 3, y + 1}, {x + 5, y + 1}, {x + 7, y + 1}, {x + 1, y + 2}]
end
