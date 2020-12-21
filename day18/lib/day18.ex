defmodule Day18 do
  @moduledoc """
  Documentation for `Day18`.
  """

  def solve1() do
    File.read!("testinput")
    |> String.split("\n")
    |> parse_input()
  end

  def parse_input(lines) do
    lines
  end

  def evaluate(line) do
    line
    |> String.codepoints()
    |> Enum.zip(0..String.length(line) -1)
    |> Enum.reduce({"", "", ""}, fn {char, index}, {operator, param1, param2} ->
      case char do
        " " ->
          {operator, param1, param2}

        "*" ->
          if operator == "" do
            {"*", param1, param2}
          else
            result = calculate({operator, param1, param2})
            {"*", result, ""}
          end

        "+" ->
          if operator == "" do
            {"+", param1, param2}
          else
            result = calculate({operator, param1, param2})
            {"+", result, ""}
          end

        "(" ->
          rest = String.slice(line, index + 1, String.length(line))

          end_index = index_of(rest, ")") - 1;
          expression = String.slice(rest, 0, end_index + 1)
          {operator, param1, evaluate(expression)}

        param ->
          if operator == "" do
            {operator, param1 <> param, param2}
          else
            {operator, param1, param2 <> param}
          end
      end
    end)
    |> calculate()
    |> String.to_integer()
  end

  def calculate({operator, param1, param2}) do
    if operator == "+" do
      (String.to_integer(param1) + String.to_integer(param2))
      |> Integer.to_string()
    else
      (String.to_integer(param1) * String.to_integer(param2))
      |> Integer.to_string()
    end
  end

  def index_of(string, search_text), do:
    :binary.match(string, search_text) |> elem(0)
end
