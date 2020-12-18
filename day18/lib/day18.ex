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
end
