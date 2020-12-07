defmodule Day7 do
  @moduledoc """
  Documentation for `Day7`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> collect()
  end

  def collect(string_list) do
    string_list
    |> Enum.filter(&(not String.starts_with?(&1, "shiny gold bag")))
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)
    |> find_shiny_gold_bag_containers()
    |> replace_occurrences(string_list)

    |> find_shiny_gold_bag_occurrences()
    |> Enum.count()
  end

  def find_shiny_gold_bag_containers(string_list) do
    Enum.reduce(string_list, [], fn string, acc ->
      if String.contains?(string, "shiny gold bag"),
        do: [first_three_words_without_last_character(string) | acc],
        else: acc
    end)
  end

  def find_shiny_gold_bag_occurrences(string_list) do
    Enum.filter(string_list, fn string ->
      String.slice(string, 1, String.length(string))
      |> String.contains?("shiny gold bag")
    end)
  end

  def replace_occurrences(replace_strings, string_list) do
    Enum.map(string_list, fn string ->
      if String.contains?(string, "shiny gold bag") do
        string
      else
        Enum.reduce(replace_strings, string, fn replace_string, acc ->
          first_char = String.at(acc, 0)
          string_without_first_char = String.slice(acc, 1, String.length(acc))

          first_char <>
            String.replace(string_without_first_char, replace_string, "shiny gold bag")
        end)
      end
    end)
  end

  # We need the singular form of bags
  def first_three_words_without_last_character(string) do
    first_three_words =
      string
      |> String.split(" ")
      |> Enum.take(3)
      |> Enum.join(" ")

    String.slice(first_three_words, 0, String.length(first_three_words) - 1)
  end
end
