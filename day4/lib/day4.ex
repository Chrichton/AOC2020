defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> passports()
    |> filter_valid()
    |> Enum.count()
  end

  def passports(lines, acc \\ []) do
    batch = Enum.take_while(lines, &(&1 != ""))
    passport = to_passport(batch)
    rest = Enum.drop_while(lines, &(&1 != ""))

    if rest == [],
      do: [passport | acc],
      else: passports(Enum.drop(rest, 1), [passport | acc])
  end

  def to_passport(batch) do
      batch
      |> Enum.join(" ")
      |> String.split(" ")
  end

  def filter_valid(passports), do: Enum.filter(passports, &valid_keylist?(&1))

  def valid_keylist?(passport) do
    keys_list = Enum.map(passport, &String.slice(&1, 0, 3))

    Enum.member?(keys_list, "byr") && Enum.member?(keys_list, "iyr") &&
      Enum.member?(keys_list, "eyr") && Enum.member?(keys_list, "hgt") &&
      Enum.member?(keys_list, "hcl") && Enum.member?(keys_list, "ecl") &&
      Enum.member?(keys_list, "pid")
  end
end
