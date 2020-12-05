defmodule Day4 do
  @moduledoc """
  Documentation for `Day4`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> get_passports()
    |> filter_valid()
    |> Enum.count()
  end

  def get_passports(lines, acc \\ []) do
    batch = Enum.take_while(lines, &(&1 != ""))
    passport = to_passport(batch)
    rest = Enum.drop_while(lines, &(&1 != ""))

    if rest == [],
      do: [passport | acc],
      else: get_passports(Enum.drop(rest, 1), [passport | acc])
  end

  def to_passport(batch) do
    batch
    |> Enum.join(" ")
    |> String.split(" ")
  end

  def filter_valid(get_passports), do: Enum.filter(get_passports, &valid_keylist?(&1))

  def valid_keylist?(passport) do
    keys_list = Enum.map(passport, &get_key/1)

    Enum.member?(keys_list, "byr") && Enum.member?(keys_list, "iyr") &&
      Enum.member?(keys_list, "eyr") && Enum.member?(keys_list, "hgt") &&
      Enum.member?(keys_list, "hcl") && Enum.member?(keys_list, "ecl") &&
      Enum.member?(keys_list, "pid")
  end

  def get_key(key_value), do: String.slice(key_value, 0, 3)

  # -----------------------

  def solve2() do
    File.read!("input")
    |> String.split("\n")
    |> get_passports()
    |> filter_valid()
    |> filter_valid_second_star()
    |> Enum.count()
  end

  def filter_valid_second_star(get_passports),
    do: Enum.filter(get_passports, &valid_passport?(&1))

  def valid_passport?(passport) do
    Enum.reduce_while(passport, false, fn key_value, acc -> valid_key_value?(key_value, acc) end)
  end

  def valid_key_value?(key_value, acc) do
    case get_key(key_value) do
      "byr" ->
        if date_valid?(get_value(key_value), 1920, 2002), do: {:cont, true}, else: {:halt, false}

      "iyr" ->
        if date_valid?(get_value(key_value), 2010, 2020), do: {:cont, true}, else: {:halt, false}

      "eyr" ->
        if date_valid?(get_value(key_value), 2020, 2030), do: {:cont, true}, else: {:halt, false}

      "hgt" ->
        if height_valid?(get_value(key_value)), do: {:cont, true}, else: {:halt, false}

      "hcl" ->
        if hair_color?(get_value(key_value)), do: {:cont, true}, else: {:halt, false}

      "ecl" ->
        if eye_color?(get_value(key_value)), do: {:cont, true}, else: {:halt, false}

      "pid" ->
        if nine_digit_number?(get_value(key_value)), do: {:cont, true}, else: {:halt, false}

      "cid" ->
        {:cont, acc}
    end
  end

  def date_valid?(value, min_date, max_date) do
    date = String.to_integer(value)
    date >= min_date && date <= max_date
  end

  def height_valid?(value) do
    length = String.length(value)
    metric = String.slice(value, length - 2, length)

    if metric == "cm" do
      height = String.slice(value, 0, length - 2) |> String.to_integer()
      height >= 150 && height <= 193
    else
      if metric == "in" do
        height = String.slice(value, 0, length - 2) |> String.to_integer()
        height >= 59 && height <= 76
      else
        false
      end
    end
  end

  def nine_digit_number?(value),
    do: String.length(value) == 9 && String.match?(value, ~r/[0-9]{9}/)

  def hair_color?(value), do: String.length(value) == 7 && String.match?(value, ~r/#[0-9,a-f]{6}/)

  def eye_color?(value), do: value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  def get_value(key_value), do: String.slice(key_value, 4, String.length(key_value))
end
