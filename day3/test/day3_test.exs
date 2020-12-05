defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  def map(), do: File.read!("testinput") |> String.split("\n")

  test "char_at_position" do
    assert Day3.char_at_position(map(), {1, 2}) == "#"
  end

  test "char_at_position x out of range" do
    assert Day3.char_at_position(map(), {13, 2}) == "#"
  end

  test "solve1" do
    assert Day3.count_trees_on_way(map()) == 2
  end

  test "solve1 input" do
    assert Day3.solve1() == 99
  end
end
