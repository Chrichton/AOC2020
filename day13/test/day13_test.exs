defmodule Day13Test do
  use ExUnit.Case
  doctest Day13

  test "parse_input" do
    assert Day13.parse_input(["939", "7,13,x,x,59,x,31,19"]) == {939, [7, 13, 59, 31, 19]}
  end

  test "solve1" do
    assert Day13.solve1() == 295
  end
end
