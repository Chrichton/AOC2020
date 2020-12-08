defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  def solve1() do
      File.read!("input")
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> find_pair_with_sum_2020()
      |> Enum.reduce(1, fn number, acc -> acc * number end)
  end

  def find_pair_with_sum_2020([number | numbers]) do
    case Enum.reduce_while(numbers, {:error, "not_found"}, fn current, _acc -> sum_2020?([number, current]) end) do
      {:ok, numbers} -> numbers
      {:error, "not_found"} -> find_pair_with_sum_2020(numbers)
    end
  end

  def sum_2020?(numbers) do
    if Enum.sum(numbers) == 2020,
      do: {:halt, {:ok, numbers}},
      else: {:cont, {:error, "not_found"}}
  end

  #------------------------------------

  def solve2() do
      File.read!("input")
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> find_triple_with_sum_2020()
      |> Enum.reduce(1, fn number, acc -> acc * number end)
  end

  def find_triple_with_sum_2020([number1 | numbers]) do
    case find_triple_with_sum_2020(number1, numbers) do
      {:ok, found_numbers} -> found_numbers
      {:error, "not_found"} -> find_triple_with_sum_2020(numbers)
    end
  end

  def find_triple_with_sum_2020(_number1, []), do: {:error, "not_found"}
  def find_triple_with_sum_2020(number1, [number2 | numbers]) do
    case Enum.reduce_while(numbers, {:error, "not_found"}, fn current, _accu -> sum_2020?([number1, number2, current]) end) do
      {:ok, found_numbers} -> {:ok, found_numbers}
      {:error, "not_found"} -> find_triple_with_sum_2020(number1, numbers)
    end
  end
end
