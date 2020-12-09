defmodule Day9 do
  @moduledoc """
  Documentation for `Day9`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(&(String.to_integer(&1)))
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
end
