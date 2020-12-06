defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  test "solve1" do
    assert Day6.solve1() == 7283
  end

  test "solve2" do
    assert Day6.solve2() == 3520
  end
end
