defmodule Day17Test do
  use ExUnit.Case
  doctest Day17

  test "active_cubes" do
    result =
      File.read!("testinput")
      |> String.split("\n")
      |> Day17.parse_input()
      |> Day17.active_cubes()

    assert result == [

             {1, 0, 0},
             {2, 1, 0},
             {0, 2, 0},
             {1, 2, 0},
             {2, 2, 0}
           ]
  end

  test "solve1" do
    assert Day17.solve1() == 42
  end
end
