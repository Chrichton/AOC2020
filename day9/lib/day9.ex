defmodule Day9 do
  @moduledoc """
  Documentation for `Day9`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> get_first_non_matching_number(25)
  end

  def get_first_non_matching_number(numbers, preamble) do
    number = Enum.at(numbers, preamble)

    if is_number_sum_of_two_numbers(number, Enum.take(numbers, preamble)),
      do: get_first_non_matching_number(Enum.drop(numbers, 1), preamble),
      else: number
  end

  def is_number_sum_of_two_numbers(number, numbers) do
    comb(2, numbers)
    |> Enum.filter(fn [number1, number2] -> number1 + number2 == number end)
    |> Enum.count() > 0
  end

  def comb(0, _), do: [[]]
  def comb(_, []), do: []

  def comb(m, [h | t]) do
    for(l <- comb(m - 1, t), do: [h | l]) ++ comb(m, t)
  end

  @result_solve1 105_950_735

  #----------------------

  def solve2() do
    numbers = File.read!("input")
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))

    sorted = find_contiguous_numbers_with_sum(numbers)
    |> Enum.sort()

    Enum.at(sorted, 0) + Enum.at(sorted, Enum.count(sorted) - 1)
  end

  @spec find_contiguous_numbers_with_sum(any) :: any
  def find_contiguous_numbers_with_sum(numbers) do
    {result, found_numbers} =
      Enum.reduce_while(numbers, {0, []}, fn number, {result, numbers} ->
        if result >= @result_solve1,
          do: {:halt, {result, numbers}},
          else: {:cont, {result + number, [number | numbers]}}
      end)

    if result == @result_solve1,
      do: found_numbers,
      else: find_contiguous_numbers_with_sum(Enum.drop(numbers, 1))
  end
end
