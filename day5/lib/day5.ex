defmodule Day5 do
  @moduledoc """
  Documentation for `Day5`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> process_seat_specifiers()
  end

  def process_seat_specifiers(seat_specifiers) do
    seat_specifiers
    |> Enum.map(&(String.codepoints(&1) |> process_regions()))
    |> max()
  end

  def max([a]), do: a
  def max([head | tail]), do: Enum.reduce(tail, head, &check_big/2)

  def check_big(a, b) when a > b, do: a
  def check_big(a, b) when a <= b, do: b

  def process_regions(region_chars) do
    row.._ = get_row(Enum.take(region_chars, 7))
    column.._ = get_column(Enum.drop(region_chars, 7))

    row * 8 + column
  end

  def get_row(row_chars) do
    Enum.reduce(row_chars, 0..127, fn row_char, acc -> next_range(acc, row_char) end)
  end

  def get_column(column_chars) do
    Enum.reduce(column_chars, 0..7, fn column_char, acc -> next_range(acc, column_char) end)
  end

  def next_range(first..last, region_char) do
    case region_char do
      "F" -> first..div(first + last, 2)
      "B" -> div(first + last + 1, 2)..last
      "L" -> first..div(first + last, 2)
      "R" -> div(first + last + 1, 2)..last
    end
  end
end
