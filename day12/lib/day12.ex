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
        {x, y, turn_left(direction, value)}

      "R" ->
        {x, y, turn_right(direction, value)}

      "F" ->
        {x, y} = move(direction, value, {x, y})
        {x, y, direction}
    end
  end

  def move(direction, value, {x, y}) do
    case direction do
      "N" -> {x, y + value}
      "E" -> {x + value, y}
      "S" -> {x, y - value}
      "W" -> {x - value, y}
    end
  end

  def turn_left(direction, degrees), do: turn(direction, degrees, "WSEN")

  def turn_right(direction, degrees), do: turn(direction, degrees, "NESW")

  def turn(direction, degrees, directions) do
    {index, _} = :binary.match(directions, direction)
    degrees = rem(degrees, 360)
    steps = div(degrees, 90)
    index = rem(index + steps, 4)
    String.at(directions, index)
  end

  def parse_command(command) do
    value =
      command
      |> String.slice(1, String.length(command))
      |> String.to_integer()

    {String.at(command, 0), value}
  end

  # ------

  def solve2() do
    {{xs, ys}, {x, y}} =
      File.read!("testinput")
      |> String.split("\n")
      |> execute_commands2({{0, 0}, {10, 1}})

    abs(xs) + abs(ys)
  end

  def execute_commands2(commands, {{xs, ys}, {x, y}}) do
    Enum.reduce(commands, {{xs, ys}, {x, y}}, fn command, acc ->
      execute_command2(command, acc)
    end)
  end

  def execute_command2(command, {{xs, ys}, {x, y}}) do
    {command, value} = parse_command(command)

    case command do
      "N" ->
        {x, y} = move("N", value, {x, y})
        {{xs, ys}, {x, y}}

      "S" ->
        {x, y} = move("S", value, {x, y})
        {{xs, ys}, {x, y}}

      "E" ->
        {x, y} = move("E", value, {x, y})
        {{xs, ys}, {x, y}}

      "W" ->
        {x, y} = move("W", value, {x, y})
        {{xs, ys}, {x, y}}

      "L" ->
        rotate_left({{xs, ys}, {x, y}}, value)

      "R" ->
        rotate_right({{xs, ys}, {x, y}}, value)

      "F" ->
        move_to_waypoint({{xs, ys}, {x, y}}, value)
    end
  end

  def move_to_waypoint({{xs, ys}, {x, y}}, value), do: {{xs + x * value, ys + y * value}, {x, y}}

  @spec rotate_right({{any, any}, {any, any}}, any) :: {{any, any}, {any, any}}
  def rotate_right({{xs, ys}, {x, y}}, degrees) do
    degrees = rem(degrees, 360)

    case degrees do
      0 -> {{xs, ys}, {x, y}}
      90 -> {{xs, ys}, {y, -x}}
      180 -> {{xs, ys}, {-y, -x}}
      270 -> {{xs, ys}, {-x, y}}
    end
  end

  def rotate_left({{xs, ys}, {x, y}}, degrees) do
    degrees = rem(degrees, 360)

    case degrees do
      0 -> {{xs, ys}, {x, y}}
      90 -> {{xs, ys}, {-x, y}}
      180 -> {{xs, ys}, {-y, -x}}
      270 -> {{xs, ys}, {y, x}}
    end
  end
end
