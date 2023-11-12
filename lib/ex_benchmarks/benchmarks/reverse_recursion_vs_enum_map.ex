defmodule ExBenchmarks.Benchmarks.ReverseRecursionVsEnumMap do
  @moduledoc false
  @behaviour ExBenchmarks.Benchmarks.Behaviour
  alias ExBenchmarks.BenchmarkRunner.BenchmarkFunction

  def name, do: "Reverse Recursion vs Enum.map"

  def run_count, do: 5

  def functions do
    [
      %BenchmarkFunction{
        name: "Reverse Recursion",
        function: &reverse_recursion/1
      },
      %BenchmarkFunction{
        name: "Enum.map",
        function: &enum_map/1
      }
    ]
  end

  def input_generator(index) do
    input_count = [10_000, 20_000, 50_000, 100_000, 200_000] |> Enum.at(index)
    input = 1..input_count |> Enum.shuffle()

    {input_count, input}
  end

  def reverse_recursion(input) do
    input
    |> do_reverse_recursion([])
    |> Enum.reverse()
  end

  def enum_map(input) do
    Enum.map(input, &(&1 * 2))
  end

  defp do_reverse_recursion([], result), do: result

  defp do_reverse_recursion([h | t], result) do
    do_reverse_recursion(t, [h * 2] ++ result)
  end
end
