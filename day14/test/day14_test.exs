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

    testinput = File.read!("testinput")

    assert Day14.parse_input(testinput) == [
             {"XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X", [{8, 11}, {7, 101}, {8, 0}]}
           ]
  end

  test "calc value" do
    Day14.calc_value("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X", 11) == 73
  end

  # test "solve1" do
  #   assert Day14.solve1() == :world
  # end
end
