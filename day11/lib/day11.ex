defmodule Day11 do
  @moduledoc """
  Documentation for `Day11`.
  """

  def solve1() do
    File.read!("testinput")
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
    |> next_state()
  end

  def foo(map) do
    for seats_str <- row <- map, do: update_seats_row(map, seats_str)
  end

  def next_state(map), do: Enum.map(map, &update_seats_row/1)

  def update_seats_row(row) do
    max_index = String.length(row) - 1

    Enum.reduce(0..max_index, [], fn index, acc ->
      if String.at(row, index) == "." do
        acc <> "."
      else
        if String.at(row, index) == "L" do
          if index == max_index || String.at(row, index + 1) == "L" ||
               String.at(row, index + 1) == "." do
            acc <> "#"
          else
            acc <> String.at(row, index)
          end
        else   # char == "#"
          if check_4_adjacent(row, acc, index) do
            acc <> "L"
          else
            acc <> String.at(row, index)
          end
        end
      end
    end)
  end

  def check_4_adjacent(row, filled_part, index) do
    check_right = row
    |> String.slice(index + 1, 4)
    |> String.starts_with?("####")

    check_left = if index == 0 do
      true
    else
      row
    |> String.slice(0, index)
    |> String.reverse()
    |> String.starts_with?("####")
    end

    check_right || check_left
  end
end
