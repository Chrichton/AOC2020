defmodule Day16Test do
  use ExUnit.Case
  doctest Day16

  # test "all_valid_ranges" do
  #   ranges = ["class: 1-3 or 5-7", "row: 6-11 or 33-44", "seat: 13-40 or 45-50"]

  #   assert Day16.parse_all_valid_ranges(ranges) == [
  #            {1, 3},
  #            {5, 7},
  #            {6, 11},
  #            {33, 44},
  #            {13, 40},
  #            {45, 50}
  #          ]
  # end

  test "solve1" do
    assert Day16.solve1() == 42
  end
end
