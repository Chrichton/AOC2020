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
end
