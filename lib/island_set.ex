defmodule IslandsEngine.IslandSet do
  alias IslandsEngine.{Island, IslandSet}

  # NOTE
  # Elixir defines structs at compile time.
  defstruct [ atoll: :none , dot: :none , l_shape: :none , s_shape: :none , square: :none ]

  def start_link() do
    Agent.start_link(fn -> initialized_set() end)
  end

  defp initialized_set() do
    Enum.reduce(keys(), %IslandSet{}, fn(key, set) ->
      {:ok, island} = Island.start_link()  # Start a new island service
      Map.put(set, key, island)            # Update the empty struct
    end)
  end

  def to_string(island_set) do
    "%IslandSet{\n" <> string_body(island_set) <> "}"
  end

  defp keys() do
    %IslandSet{}
    |> Map.from_struct
    |> Map.keys
  end

  defp string_body(island_set) do
    Enum.reduce(keys(), "", fn(key, acc) ->
      island = Agent.get(island_set, &(Map.fetch!(&1, key)))
      acc <> "    #{key} => " <> Island.to_string(island) <> "\n"
    end)
  end

end
