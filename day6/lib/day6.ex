defmodule Day6 do
  @moduledoc """
  Documentation for `Day6`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(fn s -> if s == "", do: "\n", else: s end)
    |> Enum.join()
    |> String.split("\n")
    |> Enum.map(fn s -> String.codepoints(s) |> Enum.uniq() end)
    |> Enum.reduce(0, fn chars, acc -> acc + Enum.count(chars) end)
  end

  def solve2() do
    File.read!("input")
    |> String.split("\n")
    |> Enum.reduce({[], []}, fn chars, acc ->
      {result, group} = acc

      if chars == "",
        do: {[group | result], []},
        else: {result, [String.codepoints(chars) | group]}
    end)
    |> elem(0)
    |> Enum.map(&remove_duplicates/1)
    |> Enum.reduce(0, fn list, acc -> acc + Enum.count(list) end)
  end

  def remove_duplicates([head | tail]) do
    Enum.reduce(tail, MapSet.new(head), fn list, acc ->
      MapSet.intersection(acc, MapSet.new(list))
    end)
    |> Enum.to_list()
  end
end
