defmodule Day16 do
  @moduledoc """
  Documentation for `Day16`.
  """

  def solve1() do
    File.read!("input")
    |> String.split("\n\n")
    |> parse_input()
    |> invalid_field_numbers()
    |> Enum.sum()
  end

  def invalid_field_numbers({_ny_ticket_numbers, nearby_ticket_numbers, valid_ranges}) do
    Enum.filter(nearby_ticket_numbers, fn ticket_number ->
      not contains?(valid_ranges, ticket_number)
    end)
  end

  def contains?(valid_ranges, number) do
    Enum.reduce_while(valid_ranges, false, fn {from, to}, _acc ->
      if number >= from and number <= to,
        do: {:halt, true},
        else: {:cont, false}
    end)
  end

  def parse_input([valid_ranges, my_ticket, nearby_tickets]) do
    valid_ranges = valid_ranges
    |> String.split("\n")
    |> parse_all_valid_ranges()

    my_ticket =  my_ticket
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.flat_map(&parse_ticket/1)

    nearby_tickets = nearby_tickets
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.flat_map(&parse_ticket/1)

    {my_ticket, nearby_tickets, valid_ranges}
  end

  def parse_ticket(ticket) do
    ticket
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def parse_all_valid_ranges(lines) do
    Enum.flat_map(lines, &parse_valid_ranges/1)
  end

  def parse_valid_ranges(line) do
    range1_start = index_of(line, ":") + 2
    range1_end = index_of(line, " or") - 1
    range1 = String.slice(line, range1_start, range1_end - range1_start + 1)

    range2_start = index_of(line, "or ") + 3
    range2 = String.slice(line, range2_start, String.length(line))

    [parse_valid_range(range1), parse_valid_range(range2)]
  end

  def parse_valid_range(line) do
    [from, to] = String.split(line, "-")
    {String.to_integer(from), String.to_integer(to)}
  end

  def index_of(string, search_text), do:
    :binary.match(string, search_text) |> elem(0)
end
