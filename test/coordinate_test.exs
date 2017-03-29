defmodule CoordinateTest do
  use ExUnit.Case
  doctest IslandsEngine.Coordinate

  setup_all do
    {:ok, IslandsEngine.Coordinate.start_link}
  end

  test "guessed?", coordinate do
    assert IslandsEngine.Coordinate.guessed?(coordinate) == false
  end

end
