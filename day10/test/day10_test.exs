defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  # test "solve2" do
  #   assert Day10.solve2() == 8
  # end

  test "comb" do
    list = File.read!("testinput")
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> Day10.get_all_voltage_outputs()

    assert Day10.comb(10, list) == 1
  end
end
