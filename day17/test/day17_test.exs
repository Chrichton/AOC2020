defmodule Day17Test do
  use ExUnit.Case
  doctest Day17

  def active_cubes() do
    File.read!("testinput")
    |> String.split("\n")
    |> Day17.parse_input()
    |> Day17.active_cubes()
  end

  test "get_neighbors" do
    assert Day17.get_neighbors({0, 0, 0}) ==
             MapSet.new([
               {-1, -1, -1},
               {-1, -1, 0},
               {-1, -1, 1},
               {-1, 0, -1},
               {-1, 0, 0},
               {-1, 0, 1},
               {-1, 1, -1},
               {-1, 1, 0},
               {-1, 1, 1},
               {0, -1, -1},
               {0, -1, 0},
               {0, -1, 1},
               {0, 0, -1},
               {0, 0, 1},
               {0, 1, -1},
               {0, 1, 0},
               {0, 1, 1},
               {1, -1, -1},
               {1, -1, 0},
               {1, -1, 1},
               {1, 0, -1},
               {1, 0, 0},
               {1, 0, 1},
               {1, 1, -1},
               {1, 1, 0},
               {1, 1, 1}
             ])
  end

  test "active_cubes" do
    assert active_cubes() == MapSet.new([{0, 2, 0}, {1, 0, 0}, {1, 2, 0}, {2, 1, 0}, {2, 2, 0}])
  end

  test "remaning_active_cubes" do
    assert Day17.remaning_active_cubes(active_cubes()) ==
             MapSet.new([
               {2, 1, 0},
               {1, 2, 0},
               {2, 2, 0}
             ])
  end

  # test "inactive_neighbors" do
  #   assert Day17.inactive_neighbors({1, 1, 0}, active_cubes()) == [
  #            {0, 1, 0},
  #            {1, 1, -1},
  #            {1, 1, 1}
  #          ]
  # end

  test "active_neighbors" do
    assert Day17.active_neighbors({1, 1, 0}, active_cubes()) == [
             {0, 2, 0},
             {1, 0, 0},
             {1, 2, 0},
             {2, 1, 0},
             {2, 2, 0}
           ]
  end

  test "solve1" do
    assert Day17.solve1() == 42
  end
end
