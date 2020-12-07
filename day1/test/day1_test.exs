defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  # test "greets the world" do
  #   assert Day1.hello() == :world
  # end

  test "solv1" do
    assert Day1.solve1() == 1005459
  end

  test "solve2" do
    assert Day1.solve2() == 92643264
  end
end
