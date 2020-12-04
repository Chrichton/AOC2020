defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  def solve1() do
    File.read!("input")
    |> password_lines()
    |> filter_valid_passords
    |> Enum.count()
  end

  def password_lines(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      [c1, c2, c3] = String.split(line, " ")
      {from, to} = column1_to_from_to(c1)
      {from, to, String.first(c2), c3}
    end)
  end

  def column1_to_from_to(column) do
    [from_str, to_str] = String.split(column, "-")
    {String.to_integer(from_str), String.to_integer(to_str)}
  end

  def filter_valid_passords(password_lines) do
    password_lines
    |> Enum.filter(fn {from, to, char, password} ->
      char_count = String.codepoints(password) |> Enum.filter(&(&1 == char)) |> Enum.count()
      char_count >= from && char_count <= to
    end)
  end
end
