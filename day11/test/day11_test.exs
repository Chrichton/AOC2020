defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  test "testcheck_4_adjacent right" do
    assert Day11.check_4_adjacent("##.###L", "", 0, 6) == true
  end

  test "testcheck_4_adjacent left" do
    assert Day11.check_4_adjacent("L###.##", "", 6, 6) == true
  end

  test "testcheck_4_adjacent left filled_part" do
    assert Day11.check_4_adjacent("L.##.##.##", "#.", 2, 6) == true
  end
end
