defmodule Day12 do
  @moduledoc """
  Documentation for `Day12`.
  """

  def solve1() do
    {x, y, _} =
      File.read!("input")
      |> String.split("\n")
      |> execute_commands({0, 0, "E"})

    abs(x) + abs(y)

    {x, y}
  end

  def execute_commands(commands, {x, y, direction}) do
    Enum.reduce(commands, {x, y, direction}, fn command, acc ->
      execute_command(command, acc)
    end)
  end

  def execute_command(command, {x, y, direction}) do
    {command, value} = parse_command(command)

    case command do
      "N" ->
        {x, y} = move("N", value, {x, y})
        {x, y, direction}

      "S" ->
        {x, y} = move("S", value, {x, y})
        {x, y, direction}

      "E" ->
        {x, y} = move("E", value, {x, y})
        {x, y, direction}

      "W" ->
        {x, y} = move("W", value, {x, y})
        {x, y, direction}

      "L" ->
        {x, y, turn_left(direction)}

      "R" ->
        {x, y, turn_right(direction)}

      "F" ->
        {x, y} = move(direction, value, {x, y})
        {x, y, direction}
    end
  end

  def move(direction, value, {x, y}) do
    case direction do
      "N" -> {x, y - value}
      "E" -> {x + value, y}
      "S" -> {x, y + value}
      "W" -> {x - value, y}
    end
  end

  def turn_left(direction) do
    case direction do
      "N" -> "W"
      "E" -> "N"
      "S" -> "E"
      "W" -> "S"
    end
  end

  def turn_right(direction) do
    case direction do
      "N" -> "E"
      "E" -> "S"
      "S" -> "W"
      "W" -> "N"
    end
  end

  def parse_command(command) do
    value =
      command
      |> String.slice(1, String.length(command))
      |> String.to_integer()

    {String.at(command, 0), value}
  end
end
