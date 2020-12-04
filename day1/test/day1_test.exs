defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  # test "greets the world" do
  #   assert Day1.hello() == :world
  # end

  test "solve2" do
    assert Day1.solve2() == 92643264
  end
end
