defmodule ExBenchmarks.Benchmarks.PatternMatchingVsMapGet do
  @moduledoc false
  @behaviour ExBenchmarks.Benchmarks.Behaviour

  alias ExBenchmarks.BenchmarkRunner.BenchmarkFunction

  def name, do: "Pattern Matching vs Map.get"

  def run_count, do: 5

  def functions do
    [
      %BenchmarkFunction{
        name: "Pattern Matching",
        function: &pattern_matching/1
      },
      %BenchmarkFunction{
        name: "Map.get",
        function: &map_get/1
      }
    ]
  end

  def input_generator(index) do
    input_count = [1000, 2000, 5000, 10_000, 20_000] |> Enum.at(index)

    input =
      1..input_count
      |> Enum.map(fn _ ->
        map =
          1..10
          |> Enum.reduce(%{}, fn _, map ->
            Map.put(map, Faker.Person.name(), Faker.Pokemon.name())
          end)

        key_to_find = map |> Map.keys() |> Enum.random()
        {key_to_find, map}
      end)

    {input_count, input}
  end

  def pattern_matching(input) do
    input
    |> Enum.map(fn {key_to_find, map} ->
      %{^key_to_find => value} = map
      value
    end)
  end

  def map_get(input) do
    input
    |> Enum.map(fn {key_to_find, map} ->
      Map.get(map, key_to_find)
    end)
  end
end
