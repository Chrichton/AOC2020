defmodule Day9Test do
  use ExUnit.Case
  doctest Day9

  # test "is_number_sum_of_two_numbers" do
  #   assert Day9.is_number_sum_of_two_numbers(40, [35, 20, 15, 25])
  #   assert not Day9.is_number_sum_of_two_numbers(41, [35, 20, 15, 25])

  # end

  test "solve1" do
    assert Day9.solve1() == 42
  end
end
