defmodule Day8 do
  @moduledoc """
  Documentation for `Day8`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> execute_command(0, [], 0)
  end

  def execute_command(program, instruction_pointer, visited_positions, acc) do
    if Enum.member?(visited_positions, instruction_pointer) do
      acc
    else
      {opcode, sign, value} =
        program
        |> Enum.at(instruction_pointer)
        |> get_instruction()

      case opcode do
        "nop" ->
          execute_command(
            program,
            instruction_pointer + 1,
            [instruction_pointer | visited_positions],
            acc
          )

        "acc" ->
          execute_command(
            program,
            instruction_pointer + 1,
            [instruction_pointer | visited_positions],
            acc + get_signed_value(sign, value)
          )

        "jmp" ->
          execute_command(
            program,
            instruction_pointer + get_signed_value(sign, value),
            [instruction_pointer | visited_positions],
            acc
          )
      end
    end
  end

  def get_signed_value(sign, value), do: if(sign == "+", do: value, else: -value)

  def get_instruction(line) do
    [opcode, rest] = String.split(line, " ")
    sign = String.slice(rest, 0, 1)
    value = String.slice(rest, 1, String.length(rest)) |> String.to_integer()

    {opcode, sign, value}
  end
end
