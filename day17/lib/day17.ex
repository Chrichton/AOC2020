defmodule Day17 do
  @moduledoc """
  Documentation for `Day17`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> parse_input()
    |> active_cubes(4)
    |> do_6_cycles(4, 0)
    |> Enum.count()
  end

  def do_6_cycles(active_cubes, _dimension_count, 6), do: active_cubes

  def do_6_cycles(active_cubes, dimension_count, count),
    do: do_6_cycles(next_generation(active_cubes, dimension_count), dimension_count, count + 1)

  def next_generation(active_cubes, dimension_count) do
    MapSet.union(
      remaning_active_cubes(active_cubes, dimension_count),
      new_active_cubes(active_cubes, dimension_count)
    )
  end

  def remaning_active_cubes(active_cubes, dimension_count) do
    Enum.filter(active_cubes, fn cube ->
      Enum.count(active_neighbors(cube, active_cubes, dimension_count)) in 2..3
    end)
    |> MapSet.new()
  end

  def new_active_cubes(active_cubes, dimension_count) do
    active_cubes
    |> Enum.reduce([], fn cube, acc ->
      new_actives =
        get_neighbors(cube, dimension_count)
        |> Enum.filter(fn cube ->
          active_neighbors(cube, active_cubes, dimension_count)
          |> Enum.count() == 3
        end)

      new_actives ++ acc
    end)
    |> MapSet.new()
  end

  def inactive_neighbors(cube, active_cubes, dimension_count),
    do: MapSet.difference(get_neighbors(cube, dimension_count), active_cubes)

  def active_neighbors(cube, active_cubes, dimension_count),
    do: MapSet.intersection(get_neighbors(cube, dimension_count), active_cubes)

  def active_cubes(cubes, dimensions_count) do
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

  def get_neighbors(cube, dimension_count) do
    neighbors_matrix(dimension_count)
    |> Enum.map(fn matrix_cube ->
      Enum.zip(matrix_cube, cube)
      |> Enum.map(fn {cube_component, matrix_cube_component} ->
        cube_component + matrix_cube_component
      end)
    end)
    |> MapSet.new()
  end

  def neighbors_matrix(dimensions_count) do
    shuffle([0, 1, -1], dimensions_count)
    |> Enum.filter(fn cube -> cube != List.duplicate(0, dimensions_count) end)
  end

  def shuffle(list), do: shuffle(list, length(list))

  def shuffle([], _), do: [[]]
  def shuffle(_, 0), do: [[]]

  def shuffle(list, i) do
    for x <- list, y <- shuffle(list, i - 1), do: [x | y]
  end

  def active_cubes_count(active_cubes, dimension_count) do
    Enum.map(active_cubes, fn cube ->
      Enum.count(get_neighbors(cube, dimension_count))
    end)
  end
end
