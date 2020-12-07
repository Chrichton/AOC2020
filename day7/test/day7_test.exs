defmodule Day7Test do
  use ExUnit.Case
  doctest Day7

  test "first_three_words_without_last_character" do
    assert Day7.first_three_words_without_last_character("Hallo Du da wie geht's") == "Hallo Du d"
  end

  test "solve testinput" do
    assert File.read!("testinput") |> String.split("\n") |> Day7.collect() == 4
  end

  test "solve1" do
    assert Day7.solve1() == 229
  end

  test "solve2" do
    result = File.read!("testinput")
    |> String.split("\n")
    |> Day7.calculate_contained_bags()

    assert result == 32
  end
end
