defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  test "solve1 testdata" do
    {xs, ys, _} =
      File.read!("testinput")
      |> String.split("\n")
      |> Day12.execute_commands({0, 0, "E"})

    assert abs(xs) + abs(ys) == 25
  end

  test "solve1" do
    assert Day12.solve1() == 590
  end

  test "right" do
    assert Day12.turn_right("E", 0) == "E"
    assert Day12.turn_right("E", 90) == "S"
    assert Day12.turn_right("E", 180) == "W"
    assert Day12.turn_right("E", 270) == "N"
    assert Day12.turn_right("E", 360) == "E"
  end

  test "left" do
    assert Day12.turn_left("E", 0) == "E"
    assert Day12.turn_left("E", 90) == "N"
    assert Day12.turn_left("E", 180) == "W"
    assert Day12.turn_left("E", 270) == "S"
    assert Day12.turn_left("E", 360) == "E"
  end

  test "solve testdata" do
    {{xs, ys}, _} =
      File.read!("testinput")
      |> String.split("\n")
      |> Day12.execute_commands2({{0, 0}, {10, 1}})

      assert abs(xs) + abs(ys) == 286
  end

  test "solve2" do
    assert Day12.solve2() == 286
  end
end
