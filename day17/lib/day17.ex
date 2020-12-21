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

  def do_6_cycles(active_cubes, 6), do: active_cubes

  def do_6_cycles(active_cubes, count), do: do_6_cycles(next_generation(active_cubes), count + 1)

  def next_generation(active_cubes) do
    MapSet.union(
      remaning_active_cubes(active_cubes),
      new_active_cubes(active_cubes)
    )
  end

  def remaning_active_cubes(active_cubes) do
    Enum.filter(active_cubes, fn {x, y, z} ->
      Enum.count(active_neighbors({x, y, z}, active_cubes)) in 2..3
    end)
    |> MapSet.new()
  end

  def new_active_cubes(active_cubes) do
    active_cubes
    |> Enum.reduce([], fn {x, y, z}, acc ->
      new_actives =
        active_neighbors({x, y, z}, active_cubes)
        |> Enum.filter(fn {x, y, z} ->
          active_neighbors({x, y, z}, active_cubes)
          |> Enum.count() == 3
        end)

      new_actives ++ acc
    end)

    # |> Enum.filter(fn {x, y, z} ->
    #   inactive_neighbors({x, y, z}, active_cubes)
    # end)
    # |> Enum.flat_map(fn {x, y, z} ->
    #   get_neighbors({x, y, z})
    #   |> Enum.filter(fn {x, y, z} ->
    #     active_neighbors({x, y, z}, active_cubes)
    #     |> Enum.count() == 3
    #   end)
    # end)
    |> MapSet.new()
  end

  def inactive_neighbors({x, y, z}, active_cubes) do
    Enum.filter(get_neighbors({x, y, z}), fn {x, y, z} ->
      not MapSet.member?(active_cubes, {x, y, z})
    end)
  end

  def active_neighbors({x, y, z}, active_cubes) do
    Enum.filter(get_neighbors({x, y, z}), fn {x, y, z} ->
      MapSet.member?(active_cubes, {x, y, z})
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
        {x, y, 0, char}
      end)
    end)
  end

  def get_neighbors({x, y, z}) do
    neighbors_matrix()
    |> Enum.map(fn {xm, ym, zm} -> {x + xm, y + ym, z + zm} end)
    |> MapSet.new()
  end

  def neighbors_matrix() do
    shuffle([0, 1, -1])
    |> Enum.map(fn [x, y, z] -> {x, y, z} end)
    |> Enum.filter(fn {x, y, z} -> {x, y, z} != {0, 0, 0} end)
  end

  def shuffle(list), do: shuffle(list, length(list))

  def shuffle([], _), do: [[]]
  def shuffle(_,  0), do: [[]]
  def shuffle(list, i) do
    for x <- list, y <- shuffle(list, i-1), do: [x|y]
  end



  def active_cubes_count(active_cubes) do
    Enum.map(active_cubes, fn {x, y, z} ->
      Enum.count(get_neighbors({x, y, z}))
    end)
  end

end
