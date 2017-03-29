defmodule IslandsEngine.Coordinate do
  @moduledoc """
  Coordinates are the core entities in Islands. Individual Coordinates will
  hold the state of each individual square on the game board. They only
  need to keep track of two things:

    - whether the coordinate is part of an island
    - whether a player has guessed it

  """

  defstruct [in_island: :none, guessed?: :false]

  alias IslandsEngine.Coordinate, as: Coordinate

  @doc """
  Starts a new coordinate process.

  ## Parameters

    - NONE

  ## Examples

      iex> IslandsEngine.Coordinate.start_link
      {:ok, coordinate_pid}

  """
  @spec start_link() :: {:ok, pid}
  def start_link() do
    Agent.start_link(fn -> %Coordinate{} end)
  end

  def guessed?(coordinate) do
    get(coordinate, :guessed?)
  end

  def guess(coordinate) do
    set(coordinate, :guessed?, true)
  end

  def island(coordinate) do
    get(coordinate, :in_island)
  end

  def set_in_island(coordinate, value) when is_atom value do
    set(coordinate, :in_island, value)
  end

  def in_island?(coordinate) do
    case island(coordinate) do
      :none   -> false
      _island -> true
    end
  end

  def hit?(coordinate) do
    Coordinate.in_island?(coordinate) && Coordinate.guessed?(coordinate)
  end

  def get(pid, key) do
    Agent.get(pid, fn(state) -> Map.get(state, key) end)
  end

  def set(pid, key, value) do
    Agent.update(pid, fn(state) -> Map.put(state, key, value) end)
  end

  def to_string(coordinate) do
    "(in_island: #{island(coordinate)}, guessed: #{guessed?(coordinate)})"
  end

end
