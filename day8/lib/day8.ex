defmodule Day8 do
  @moduledoc """
  Documentation for `Day8`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n")
    |> execute_command(0, [], 0)
    |> elem(1)
  end

  def execute_command(program, instruction_pointer, visited_positions, acc) do
    if Enum.member?(visited_positions, instruction_pointer) do
      {:infinte_loop, acc}
    else
      if instruction_pointer >= Enum.count(program) do
        {:ok, acc}
      else
        execute_command_without_check(program, instruction_pointer, visited_positions, acc)
      end
    end
  end

  def execute_command_without_check(program, instruction_pointer, visited_positions, acc) do
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

  def get_signed_value(sign, value), do: if(sign == "+", do: value, else: -value)

  def get_instruction(line) do
    [opcode, rest] = String.split(line, " ")
    sign = String.slice(rest, 0, 1)
    value = String.slice(rest, 1, String.length(rest)) |> String.to_integer()

    {opcode, sign, value}
  end

  def solve2() do
    File.read!("input")
    |> String.split("\n")
    |> patch_program()
  end

  def patch_program(program) do
    case run_patched_program_recursive(program, 0, "nop", "jmp") do
      {:ok, acc} ->
        acc

      _ ->
        {:ok, acc} = run_patched_program_recursive(program, 0, "jmp", "nop")
        acc
    end
  end

  def run_patched_program_recursive(program, number_of_patched_lines, from_opcode, to_opcode) do
    already_patched_lines = Enum.take(program, number_of_patched_lines)
    lines_to_patch = Enum.drop(program, number_of_patched_lines)

    patch_index = Enum.find_index(lines_to_patch, &String.starts_with?(&1, from_opcode))

    if patch_index == nil do
      {:error, from_opcode <> " not found"}
    else
      patched_lines =
        List.update_at(
          lines_to_patch,
          patch_index,
          &(to_opcode <> String.slice(&1, 3, String.length(&1)))
        )

      patched_program = already_patched_lines ++ patched_lines

      case execute_command(patched_program, 0, [], 0) do
        {:infinte_loop, _} ->
          run_patched_program_recursive(
            program,
            patch_index + Enum.count(already_patched_lines) + 1,
            from_opcode,
            to_opcode
          )

        {:ok, acc} ->
          {:ok, acc}
      end
    end
  end
end
