defmodule Day10 do
  @moduledoc """
  Documentation for `Day10`.
  """
  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> get_all_voltage_outputs()
    |> get_differences()
    |> multiply_1_3_jolt_differences()
  end

  def get_all_voltage_outputs(voltage_outputs) do
    sorted_voltage_outputs = Enum.sort(voltage_outputs, :desc)

    [Enum.at(sorted_voltage_outputs, 0) + 3 | sorted_voltage_outputs]
    |> Enum.reverse()
  end

  def get_differences(voltage_outputs) do
    first_number = Enum.at(voltage_outputs, 0)

    voltage_outputs
    |> Enum.drop(1)
    |> Enum.reduce(
      {[first_number], first_number},
      fn jolt, {result, last_jolt} -> {[jolt - last_jolt | result], jolt} end
    )
    |> elem(0)
  end

  def multiply_1_3_jolt_differences(differences) do
    diff1_count = Enum.filter(differences, &(&1 == 1)) |> Enum.count()
    diff3_count = Enum.filter(differences, &(&1 == 3)) |> Enum.count()

    diff1_count * diff3_count
  end

  def solve2() do
    File.read!("input")
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
    |> get_all_voltage_outputs()
    |> get_all_combinations()
  end

  def get_all_combinations(voltage_outputs) do
    voltage_outputs_count = Enum.count(voltage_outputs)
    reversed = Enum.reverse(voltage_outputs)
    last_voltage_output = Enum.at(reversed, 0)

    reversed
    |> Enum.drop(1)
    |> Enum.reverse()
    |> get_all_combinations_recursive(voltage_outputs_count, last_voltage_output, 2, 0)
  end

  def get_all_combinations_recursive(_, _, voltage_outputs_count, m, count) when m == voltage_outputs_count + 1, do: count
  def get_all_combinations_recursive(voltage_outputs, voltage_outputs_count,
                                     last_voltage_output, m, count) do
    actual_count =
      comb(m, voltage_outputs)
      |> Enum.filter(fn voltage_outputs ->
        voltage_outputs_added = voltage_outputs ++ [last_voltage_output]
        check_difference(voltage_outputs_added)
      end)
      |> Enum.count()

    get_all_combinations_recursive(
      voltage_outputs,
      voltage_outputs_count,
      last_voltage_output,
      m + 1,
      count + actual_count
    )
  end

  def check_difference(voltage_outputs) do
    {result, _} =
      Enum.reduce_while(voltage_outputs, {false, 0}, fn number, {_, last_number} ->
        if number - last_number <= 3,
          do: {:cont, {true, number}},
          else: {:halt, {false, number}}
      end)

    result
  end

  def comb(0, _), do: [[]]
  def comb(_, []), do: []

  def comb(m, [h | t]) do
    for(l <- comb(m - 1, t), do: [h | l]) ++ comb(m, t)
  end
end
