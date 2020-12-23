defmodule Day17 do
  @moduledoc """
  Documentation for `Day17`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> parse_input()
    |> active_cubes()
    |> do_6_cycles(0)
    |> Enum.count()
  end

  def do_6_cycles(active_cubes, 6), do: active_cubes

  def do_6_cycles(active_cubes, count), do: do_6_cycles(next_generation(active_cubes), count + 1)

  def next_generation(active_cubes) do
    MapSet.union(
      remaning_active_cubes(active_cubes),
      new_active_cubes(active_cubes)
    )
  end

  def remaning_active_cubes(active_cubes) do
    Enum.filter(active_cubes, fn cube ->
      Enum.count(active_neighbors(cube, active_cubes)) in 2..3
    end)
    |> MapSet.new()
  end

  def new_active_cubes(active_cubes) do
    active_cubes
    |> Enum.reduce([], fn cube, acc ->
      new_actives =
        get_neighbors(cube)
        |> Enum.filter(fn cube ->
          active_neighbors(cube, active_cubes)
          |> Enum.count() == 3
        end)

      new_actives ++ acc
    end)
    |> MapSet.new()
  end

  def inactive_neighbors(cube, active_cubes),
    do: MapSet.difference(get_neighbors(cube), active_cubes)

  def active_neighbors(cube, active_cubes),
    do: MapSet.intersection(get_neighbors(cube), active_cubes)

  def active_cubes(cubes, dimensions_count \\ 3) do
    cubes
    |> Enum.filter(fn {_x, _y, char} ->
      char == "#"
    end)
    |> Enum.map(fn {x, y, _} ->
      tail = List.duplicate(0, dimensions_count - 2)
      [x | [y | tail]]
    end)
    |> MapSet.new()
  end

  def parse_input(lines) do
    lines
    |> Enum.zip(0..(Enum.count(lines) - 1))
    |> Enum.flat_map(fn {line, y} ->
      columns = String.codepoints(line)

      columns
      |> Enum.zip(0..(Enum.count(columns) - 1))
      |> Enum.map(fn {char, x} ->
        {x, y, char}
      end)
    end)
  end

  def get_neighbors(cube) do
    neighbors_matrix()
    |> Enum.map(fn matrix_cube ->
      Enum.zip(matrix_cube, cube)
      |> Enum.map(fn {cube_component, matrix_cube_component} ->
        cube_component + matrix_cube_component
      end)
    end)
    |> MapSet.new()
  end

  def neighbors_matrix(dimensions_count \\ 3) do
    shuffle([0, 1, -1], dimensions_count)
    |> Enum.filter(fn cube -> cube != [0, 0, 0] end)
  end

  def shuffle(list), do: shuffle(list, length(list))

  def shuffle([], _), do: [[]]
  def shuffle(_, 0), do: [[]]

  def shuffle(list, i) do
    for x <- list, y <- shuffle(list, i - 1), do: [x | y]
  end

  def active_cubes_count(active_cubes) do
    Enum.map(active_cubes, fn cube ->
      Enum.count(get_neighbors(cube))
    end)
  end
end
