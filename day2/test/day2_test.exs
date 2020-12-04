defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "solve1" do
    assert Day2.solve1() == 439
  end

  test "solve2" do
    assert Day2.solve2() == 584
  end
end
