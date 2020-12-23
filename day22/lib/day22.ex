defmodule Day22 do
  @moduledoc """
  Documentation for `Day22`.
  """
  defmodule Game do
    defstruct p1_cards: [],
              p2_cards: []
  end

  def solve1() do
    File.read!("input")
    |> parse()
    |> play_game()
  end

  def play_game(%Game{p1_cards: []} = game), do: calculate_score(game.p2_cards)
  def play_game(%Game{p2_cards: []} = game), do: calculate_score(game.p1_cards)
  def play_game(%Game{} = game) do
    [p1_card | p1_tail] = game.p1_cards
    [p2_card | p2_tail] = game.p2_cards

    next_game = if p1_card > p2_card,
      do: %Game{p1_cards: p1_tail ++ [p1_card] ++ [p2_card], p2_cards: p2_tail},
      else: %Game{p1_cards: p1_tail, p2_cards: p2_tail ++ [p2_card] ++ [p1_card]}

      play_game(next_game)
  end

  def calculate_score(cards) do
    cards
    |> Enum.reverse()
    |> Enum.zip(1..Enum.count(cards))
    |> Enum.reduce(0, fn {number, factor}, acc -> acc + number * factor end)
  end

  def parse(input) do
    [player_1_cards, player_2_cards] =
      input
      |> String.split("\n\n")
      |> Enum.map(&parse_player_cards/1)

    %Game{p1_cards: player_1_cards, p2_cards: player_2_cards}
  end

  def parse_player_cards(player_string) do
    player_string
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer(&1))
  end
end
