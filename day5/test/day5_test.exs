defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "exmple" do
    seat_id = File.read!("testinput")
    |> String.codepoints()
    |> Day5.process_regions()

    assert seat_id == 357
  end
end
