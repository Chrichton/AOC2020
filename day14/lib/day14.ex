defmodule Day14 do
  @moduledoc """
  Documentation for `Day14`.
  """

  def solve1() do
    File.read!("input")
    |> parse_input()
    |> sum_memory_values()
  end

  # [{_mask, [{_mem_address, _value}]}]
  def sum_memory_values(masks_values) do
    Enum.reduce(masks_values, %{}, fn mask_values, acc ->
      calc_memory_value(mask_values, acc)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  # {mask, [{_mem_address, _value}]}
  def calc_memory_value({mask, values}, memory_map) do
    Enum.reduce(values, memory_map, fn {mem_address, value}, acc ->
      Map.put(acc, mem_address, calc_value(mask, value))
    end)
  end

  def calc_value(mask, mem_value) do
    binary_string =
      mem_value
      |> Integer.to_string(2)
      |> String.pad_leading(String.length(mask), "0")

    Enum.zip(
      String.codepoints(mask),
      String.codepoints(binary_string)
    )
    |> Enum.reduce("", fn {mask_char, value_char}, acc ->
      if mask_char == "X",
        do: acc <> value_char,
        else: acc <> mask_char
    end)
    |> to_char_list()
    |> List.to_integer(2)
  end

  def parse_input(lines) do
    lines
    |> String.split("mask = ")
    |> Enum.drop(1)
    |> Enum.map(fn line ->
      lines = String.split(line, "\n", trim: true)
      memories = parse_memories(Enum.drop(lines, 1))

      {Enum.at(lines, 0), memories}
    end)
  end

  def parse_memories(lines), do: Enum.map(lines, &parse_memory/1)

  def parse_memory(line) do
    components = String.split(line, " = ")

    mem = Enum.at(components, 0)
    start_index = elem(:binary.match(mem, "["), 0) + 1
    end_index = elem(:binary.match(mem, "]"), 0) - 1

    mem =
      String.slice(mem, start_index, end_index - start_index + 1)
      |> String.to_integer()

    value =
      components
      |> Enum.at(1)
      |> String.to_integer()

    {mem, value}
  end

  # -------------

  def solve2() do
    File.read!("testinput2")
    |> parse_input()
    |> sum_memory_values2()
  end

  def sum_memory_values2(masks_values) do
    Enum.reduce(masks_values, %{}, fn mask_values, acc ->
      calc_memory_value2(mask_values, acc)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  # {mask, [{_mem_address, _value}]}
  def calc_memory_value2({mask, values}, memory_map) do
    Enum.reduce(values, memory_map, fn {mem_address, value}, acc ->
      Map.put(acc, mem_address, calc_value2(mask, value))
    end)
  end

  def calc_value2(mask, mem_value) do
    binary_string =
      mem_value
      |> Integer.to_string(2)
      |> String.pad_leading(String.length(mask), "0")

    get_binary_strings(binary_string, mask)
    |> Enum.map(fn binary_string ->
      binary_string
      |> to_char_list()
      |> List.to_integer(2)
    end)
    |> Enum.sum()
  end

  def get_binary_strings(binary_string, mask) do
    Enum.zip(
      String.codepoints(mask),
      String.codepoints(binary_string)
    )
    |> Enum.reduce("", fn {mask_char, value_char}, acc ->
      if mask_char == "0",
        do: acc <> value_char,
        else: acc <> mask_char
    end)
    |> get_binary_strings()
  end

  def get_binary_strings(binary_string_with_x) do
    codepoints = String.codepoints(binary_string_with_x)
    x_count = Enum.count(codepoints, &(&1 == "X"))

    Enum.map(floating_permutations(x_count), fn permutation ->
      Enum.reduce(codepoints, {"", permutation, 0},
      fn char, {result, permutation, permutation_index} ->
        if char == "X",
          do:
            {result <> (Enum.at(permutation, permutation_index) |> Integer.to_string()), permutation,
             permutation_index + 1},
          else: {result <> char, permutation, permutation_index}
      end)
      |> elem(0)
    end)
  end

  # 2 -> 0,0 0,1 1,0 1,1
  # def permutations(number) do
  #   for x <- 1..number, y <- 1..number, (x, y)
  # end

  def floating_permutations(number) do
    Enum.map(0..(number - 1), & &1)
    |> shuffle()
    |> Enum.filter(fn list ->
      Enum.all?(list, &(&1 <= 1))
    end)
  end

  # def permutations([]), do: [[]]

  # def permutations(list),
  #   do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])

  def shuffle(list), do: shuffle(list, length(list))

  def shuffle([], _), do: [[]]
  def shuffle(_, 0), do: [[]]

  def shuffle(list, i) do
    for x <- list, y <- shuffle(list, i - 1), do: [x | y]
  end
end
