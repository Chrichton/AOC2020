defmodule Day15 do
  @moduledoc """
  Documentation for `Day15`.
  """

  def solve1() do
    initial_numbers =
      File.read!("input")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()

    next_number_recursive(initial_numbers, Enum.count(initial_numbers))
  end

  def next_number_recursive([number_spoken | _], 2020), do: number_spoken

  def next_number_recursive(numbers_spoken, count) do
    last_number = Enum.at(numbers_spoken, 0)
    rest = Enum.drop(numbers_spoken, 1)

    numbers_spoken =
      if Enum.member?(rest, last_number),
        do: [index_of(rest, last_number) + 1 | numbers_spoken],
        else: [0 | numbers_spoken]

    next_number_recursive(numbers_spoken, count + 1)
  end

  def index_of(numbers_spoken, number) do
    Enum.find_index(numbers_spoken, &(&1 == number))
  end
end
