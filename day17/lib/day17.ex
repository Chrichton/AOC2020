defmodule Day17 do
  @moduledoc """
  Documentation for `Day17`.
  """

  def solve1() do
    File.read!("testinput")
    |> String.split("\n")
    |> parse_input()
    |> active_cubes()
    |> do_6_cycles(0)
    |> Enum.count()
  end

  def do_6_cycles(active_cubes, 7), do: active_cubes

  def do_6_cycles(active_cubes, count), do: do_6_cycles(next_geneation(active_cubes), count + 1)

  def next_geneation(active_cubes) do
    remaning_actives =
      Enum.filter(active_cubes, fn {x, y, z} ->
        Enum.count(get_neighbors({x, y, z})) in 2..3
      end)

    new_actives = new_active_cubes(active_cubes)

    remaning_actives ++ new_actives
  end

  def new_active_cubes(active_cubes) do
    active_cubes
    # neighbors, that are not active
    |> Enum.filter(fn {x, y, z} ->
      not Enum.member?(get_neighbors({x, y, z}), {x, y, z})
    end)
    |> Enum.flat_map(fn {x, y, z} ->
      # inactive neighbors
      get_neighbors({x, y, z})
      |> Enum.filter(fn {x, y, z} ->
        neighbors_from_inactive_cube =
          get_neighbors({x, y, z})
          # neighbors, that are active
          |> Enum.filter(fn {x, y, z} ->
            Enum.member?(get_neighbors({x, y, z}), {x, y, z})
          end)

        Enum.count(neighbors_from_inactive_cube) == 3
      end)
    end)
  end

  def active_cubes(cubes) do
    cubes
    |> Enum.filter(fn {_x, _y, _z, char} ->
      char == "#"
    end)
    |> Enum.map(fn {x, y, z, _} ->
      {x, y, z}
    end)
  end

  def parse_input(lines) do
    lines
    |> Enum.zip(0..(Enum.count(lines) - 1))
    |> Enum.flat_map(fn {line, y} ->
      columns = String.codepoints(line)

      columns
      |> Enum.zip(0..(Enum.count(columns) - 1))
      |> Enum.map(fn {char, x} ->
        {x, y, 0, char}
      end)
    end)
  end

  def get_neighbors({x, y, z}) do
    [
      {x + 1, y, z},
      {x, y + 1, z},
      {x, y, z + 1},
      {x - 1, y, z},
      {x, y - 1, z},
      {x, y, z - 1}
    ]
  end
end
