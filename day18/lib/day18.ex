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
    |> Enum.zip(0..(String.length(line) - 1))
    |> Enum.reduce({"", "", "", 0}, fn {char, index}, {operator, param1, param2, skip_count} ->
      if skip_count > 0 do
        {operator, param1, param2, skip_count - 1}
      else
        case char do
          " " ->
            {operator, param1, param2, 0}

          "*" ->
            if operator == "" do
              {"*", param1, param2, 0}
            else
              result = calculate({operator, param1, param2})
              {"*", result, "", 0}
            end

          "+" ->
            if operator == "" do
              {"+", param1, param2, 0}
            else
              result = calculate({operator, param1, param2})
              {"+", result, "", 0}
            end

          "(" ->
            rest = String.slice(line, index + 1, String.length(line))

            end_index = index_of(rest, ")") - 1
            expression = String.slice(rest, 0, end_index + 1)
            {operator, param1, evaluate(expression), end_index + 2}

          param ->
            if operator == "" do
              {operator, param1 <> param, param2, 0}
            else
              {operator, param1, param2 <> param, 0}
            end
        end
      end
    end)
    |> Tuple.delete_at(3)
    |> calculate()
  end

  def calculate({"+", param1, param2}) do
    (String.to_integer(param1) + String.to_integer(param2))
    |> Integer.to_string()
  end

  def calculate({"*", param1, param2}) do
    (String.to_integer(param1) * String.to_integer(param2))
    |> Integer.to_string()
  end

  def index_of(string, search_text), do: :binary.match(string, search_text) |> elem(0)
end
