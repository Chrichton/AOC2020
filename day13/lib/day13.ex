defmodule Day13 do
  @moduledoc """
  Documentation for `Day13`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> parse_input()
    |> get_difference()
  end

  @spec get_difference({number, any}) :: number
  def get_difference({departure_time, bus_ids}) do
    {bus_departure_time, bus_id} = get_earlies_departure({departure_time, bus_ids})
    (bus_departure_time - departure_time) * bus_id
  end

  def get_earlies_departure({departure_time, bus_ids}) do
    bus_ids
    |> Enum.map(&get_nearest_departure_time(departure_time, &1))
    |> Enum.sort_by(fn {departure_time, _} -> departure_time end)
    |> Enum.at(0)
  end

  def get_nearest_departure_time(departure_time, bus_id),
    do: {ceil(departure_time / bus_id) * bus_id, bus_id}

  def parse_input([current_time_string, ids_string]) do
    current_time = String.to_integer(current_time_string)

    ids =
      ids_string
      |> String.split(",")
      |> Enum.filter(&(&1 != "x"))
      |> Enum.map(&String.to_integer/1)

    {current_time, ids}
  end

  # -------------

  def solve2() do
    File.read!("testinput")
    |> String.split("\n")
    |> Enum.at(1)
    |> parse_input2()
    |> Enum.reverse()
    |> find_coincidence()
  end

  def parse_input2(ids_string) do
    ids_string
    |> String.split(",")
    |> Enum.reduce({[], 0}, fn char, {result, timestamp} ->
      if char == "x" do
        {result, timestamp + 1}
      else
        bus_id = String.to_integer(char)
        {[{bus_id, timestamp} | result], timestamp + 1}
      end
    end)
    |> elem(0)
  end

  def find_coincidence(pairs) do
    factor =
      pairs
      |> Enum.at(0)
      |> elem(0)

    find_coincidence_recursive(pairs, factor)
  end

  def find_coincidence_recursive(pairs, timestamp) do
    if check_coincidence(pairs, timestamp),
      do: timestamp,
      else: find_coincidence_recursive(pairs, timestamp + timestamp)
  end

  def check_coincidence(pairs, current_timestamp) do
    pairs
    |> Enum.map(fn {bus_id, timestamp} ->
      {timestamp, get_nearest_departure_time(current_timestamp, bus_id)}
    end)
    |> Enum.filter(fn {timestamp, nearest_departure_time} ->
      timestamp == nearest_departure_time
    end)
    |> Enum.count() == 1
  end
end
