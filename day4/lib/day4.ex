defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> passports()
    |> to_keys_lists()
    |> filter_valid()
    |> Enum.count()
  end

  def passports(lines, acc \\ []) do
    batch = Enum.take_while(lines, &(&1 != ""))
    rest = Enum.drop_while(lines, &(&1 != ""))

    if rest == [],
      do: [batch | acc],
      else: passports(Enum.drop(rest, 1), [batch | acc])
  end

  def to_keys_lists(passports) do
    Enum.map(passports, fn passport ->
      passport
      |> Enum.join(" ")
      |> String.split(" ")
      |> Enum.map(&String.slice(&1, 0, 3))
    end)
  end

  def filter_valid(keys_lists), do: Enum.filter(keys_lists, &valid_keylist?(&1))

  def valid_keylist?(keys_list) do
    Enum.member?(keys_list, "byr") && Enum.member?(keys_list, "iyr") &&
      Enum.member?(keys_list, "eyr") && Enum.member?(keys_list, "hgt") &&
      Enum.member?(keys_list, "hcl") && Enum.member?(keys_list, "ecl") &&
      Enum.member?(keys_list, "pid")
  end
end
