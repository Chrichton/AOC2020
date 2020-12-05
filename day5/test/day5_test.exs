defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "exmple" do
    seat_id = File.read!("testinput")
    |> String.codepoints()
    |> Day5.process_regions()

    assert seat_id == 357
  end

  test "solve1" do
    assert Day5.solve1() == 994
  end

  test "solve2" do
    assert Day5.solve2() == 741
  end
end
