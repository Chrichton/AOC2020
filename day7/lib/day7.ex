defmodule Day7 do
  @moduledoc """
  Documentation for `Day7`.
  """

  @shiny_gold_bag "shiny gold bag"

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> collect()
  end

  def collect(string_list) do
    string_list
    |> Enum.filter(&(not String.starts_with?(&1, @shiny_gold_bag)))
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
      if String.contains?(string, @shiny_gold_bag),
        do: [first_three_words_without_last_character(string) | acc],
        else: acc
    end)
  end

  def find_shiny_gold_bag_occurrences(string_list) do
    Enum.filter(string_list, fn string ->
      String.slice(string, 1, String.length(string))
      |> String.contains?(@shiny_gold_bag)
    end)
  end

  def replace_occurrences(replace_strings, string_list) do
    Enum.map(string_list, fn string ->
      if String.contains?(string, @shiny_gold_bag) do
        string
      else
        Enum.reduce(replace_strings, string, fn replace_string, acc ->
          first_char = String.at(acc, 0)
          string_without_first_char = String.slice(acc, 1, String.length(acc))

          first_char <>
            String.replace(string_without_first_char, replace_string, @shiny_gold_bag)
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

  # -----------------------

  def solve2() do
    File.read!("testinput")
    |> String.split("\n")
    |> calculate_contained_bags()
  end

  def calculate_contained_bags(bags) do
    calculate_contained_bags_recursive(bags, to_name_quantity_list(bags, @shiny_gold_bag), [])
  end

  def calculate_contained_bags_recursive(bags, names_quantities, acc) do
    acc = acc ++ names_quantities

    current_names_quantities =
      names_quantities
      |> Enum.flat_map(fn {name, _} -> to_name_quantity_list(bags, name) end)
      |> Enum.filter(fn {_, quantity} -> quantity > 0 end)

    if Enum.count(current_names_quantities) == 0 do
      acc
    else
      current_names_quantities = update_current_names_quantities(current_names_quantities, acc)

      calculate_contained_bags_recursive(
        bags,
        current_names_quantities,
        acc
      )
    end
  end

  def update_current_names_quantities(current_names_quantities, acc) do
    Enum.map(current_names_quantities, fn {name, quantity} ->
      case Enum.find(acc, fn {acc_name, _} -> acc_name == name end) do
        {_, acc_quantity} -> {name, quantity * acc_quantity}
        _ -> {name, quantity}
      end
    end)
  end

  #  :: [{name, quantity}]
  def to_name_quantity_list(bags, bag_name) do
    [bag] = Enum.filter(bags, &String.starts_with?(&1, bag_name))

    String.split(bag, " ")
    |> Enum.drop(4)
    |> Enum.join(" ")
    |> String.trim()
    |> String.split(",")
    |> Enum.filter(&(not String.contains?(&1, @shiny_gold_bag)))
    |> Enum.map(fn bag_line ->
      components =
        bag_line
        |> String.trim()
        |> String.split(" ")

      quantity =
        if Enum.at(components, 0) == "no",
          do: 0,
          else: String.to_integer(Enum.at(components, 0))

      name =
        components
        |> Enum.drop(1)
        |> Enum.join(" ")
        |> String.replace(".", "")

      {name, quantity}
    end)
  end
end
