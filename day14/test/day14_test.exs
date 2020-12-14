defmodule Day14Test do
  use ExUnit.Case
  doctest Day14

  test "parse_input" do
    line = """
    mask = X
    mem1
    mem2
    mask = 0
    mem3
    mem4
    """

    testinput = File.read!("testinput2")

    assert Day14.parse_input(testinput) == [
             {"0X10110X1001000X10X00X01000X01X01101", [{49559, 97}]},
             {"00XX1111100100XX1000X1X00001111X1010", [{16422, 941_878_948}]}
           ]
  end

  test "calc value" do
    Day14.calc_value("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X", 11) == 73
  end

  test "solve1 testdata" do
    result =
      File.read!("testinput")
      |> Day14.parse_input()
      |> Day14.sum_memory_values()

      assert result == 165
  end

  test "solve1" do
    assert Day14.solve1() == 8703805870726
  end
end
