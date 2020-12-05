defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "solve1" do
    assert Day4.solve1() == 190
  end

  test "solve2" do
    assert Day4.solve2() == 121
  end
end
