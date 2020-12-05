defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  @testinput """
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  """

  def map(), do: String.split(@testinput, "\n")

  test "char_at_position" do
    assert Day3.char_at_position(map, {1, 2}) == "#"
  end

  test "char_at_position x out of range" do
    assert Day3.char_at_position(map, {13, 2}) == "#"
  end

  test "solve1" do
    Day3.count_trees_on_way(map()) == 7
  end
end
