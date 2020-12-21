defmodule Day18Test do
  use ExUnit.Case
  doctest Day18

  # test "evaluate simple" do
  #   assert Day18.evaluate("1 + 2 * 3 + 4 * 5 + 6") == 71
  # end

  test "evaluate" do
    assert Day18.evaluate("1 + (2 * 3) + (4 * (5 + 6))") == 51
  end
end
