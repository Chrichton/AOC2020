defmodule Day22 do
  @moduledoc """
  Documentation for `Day22`.
  """
  defmodule Game do
    defstruct p1_cards: [],
              p2_cards: [],
              previous_decks: MapSet
  end

  def solve2() do
    File.read!("input")
    |> parse()
    |> play_game(false)
  end

  def winner_player1?(p1_card, p2_card), do: p1_card > p2_card
  def winner_player1?(player), do: player == :player1

  def play_game(%Game{p1_cards: []}, true), do: :player2
  def play_game(%Game{p2_cards: []}, true), do: :player1
  def play_game(%Game{p1_cards: []} = game, false), do: calculate_score(game.p2_cards)
  def play_game(%Game{p2_cards: []} = game, false), do: calculate_score(game.p1_cards)

  def play_game(%Game{} = game, is_recursive_combat) do
    if MapSet.member?(game.previous_decks, {game.p1_cards, game.p2_cards}) do
      if is_recursive_combat,
        do: :player1,
        else: calculate_score(game.p1_cards)
    else
      [p1_card | p1_tail] = game.p1_cards
      [p2_card | p2_tail] = game.p2_cards

      is_winner_player1 =
        if Enum.count(p1_tail) >= p1_card && Enum.count(p2_tail) >= p2_card do
          play_sub_game(%Game{
            p1_cards: Enum.slice(p1_tail, 0, p1_card),
            p2_cards: Enum.slice(p2_tail, 0, p2_card),
            previous_decks: %MapSet{}
          })
          |> winner_player1?()
        else
          winner_player1?(p1_card, p2_card)
        end

      game
      |> get_next_game(p1_card, p1_tail, p2_card, p2_tail, is_winner_player1)
      |> play_game(is_recursive_combat)
    end
  end

  def get_next_game(%Game{} = game, p1_card, p1_tail, p2_card, p2_tail, is_winner_player1) do
    if is_winner_player1,
      do: %Game{
        p1_cards: p1_tail ++ [p1_card, p2_card],
        p2_cards: p2_tail,
        previous_decks: MapSet.put(game.previous_decks, {game.p1_cards, game.p2_cards})
      },
      else: %Game{
        p1_cards: p1_tail,
        p2_cards: p2_tail ++ [p2_card, p1_card],
        previous_decks: MapSet.put(game.previous_decks, {game.p1_cards, game.p2_cards})
      }
  end

  def play_sub_game(%Game{} = game), do: play_game(game, true)

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

    %Game{
      p1_cards: player_1_cards,
      p2_cards: player_2_cards,
      previous_decks: %MapSet{}
    }
  end

  def parse_player_cards(player_string) do
    player_string
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&String.to_integer(&1))
  end
end
