defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  def solve1() do
    {number1, number2} =
      File.read!("input")
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> find_pair_with_sum_2020()

    number1 * number2
  end

  def find_pair_with_sum_2020([number | numbers]) do
    case Enum.reduce_while(numbers, {:error, "not_found"}, fn x, _accu -> sum_2020?(number, x) end) do
      {:ok, {first_number, second_number}} -> {first_number, second_number}
      _ -> find_pair_with_sum_2020(numbers)
    end
  end

  def sum_2020?(number1, number2) do
    if number1 + number2 == 2020,
      do: {:halt, {:ok, {number1, number2}}},
      else: {:cont, {:error, "not_found"}}
  end

  #------------------------------------

  def solve2() do
    {number1, number2, number3} =
      File.read!("input")
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> find_triple_with_sum_2020()

    number1 * number2 * number3
  end

  def find_triple_with_sum_2020([number1 | numbers]) do
    result = find_triple_with_sum_2020(number1, numbers)
    case result do
      {:ok, {first_number, second_number, third_number}} -> {first_number, second_number, third_number}
      _ -> find_triple_with_sum_2020(numbers)
    end
  end

  def find_triple_with_sum_2020(_number1, []), do: {:error, "not_found"}
  def find_triple_with_sum_2020(number1, [number2 | numbers]) do
    case Enum.reduce_while(numbers, {:error, "not_found"}, fn x, _accu -> sum_2020?(number1, number2, x) end) do
      {:ok, {first_number, second_number, third_number}} -> {:ok, {first_number, second_number, third_number}}
      _ -> find_triple_with_sum_2020(number1, numbers)
    end
  end

  def sum_2020?(number1, number2, number3) do
    if number1 + number2 + number3 == 2020,
      do: {:halt, {:ok, {number1, number2, number3}}},
      else: {:cont, {:error, "not_found"}}
  end
end
