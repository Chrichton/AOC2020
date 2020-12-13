defmodule Day13Test do
  use ExUnit.Case
  doctest Day13

  test "parse_input" do
    assert Day13.parse_input(["939", "7,13,x,x,59,x,31,19"]) == {939, [7, 13, 59, 31, 19]}
  end

  test "solve1" do
    assert Day13.solve1() == 119
  end

  test "parse_input2" do
    assert Day13.parse_input2("7,13,x,x,59,x,31,19") == [{19, 19 - 7}, {31, 31 - 6}, {59, 59 - 4}, {13, 13 - 1}, {7, 0}]
  end

  test "solve2 testdata" do
    result = File.read!("testinput2")
    |> String.split("\n")
    |> Enum.at(1)
    |> Day13.parse_input2()
    |> Enum.reverse()
    |> Day13.find_coincidence()

    assert result == 3417
  end

  # test "solve2" do
  #   assert Day13.solve2() == 3417
  # end
end
