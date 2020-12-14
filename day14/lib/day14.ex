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
end
