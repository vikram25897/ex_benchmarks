defmodule ExBenchmarks.Benchmarks.EnumMemberVsRecursion do
  @moduledoc false
  @behaviour ExBenchmarks.Benchmarks.Behaviour
  alias ExBenchmarks.BenchmarkRunner.BenchmarkFunction

  @impl true
  def name, do: "Enum.member vs Recursion"

  @impl true
  def functions do
    [
      %BenchmarkFunction{
        name: "Enum.member",
        function: &enum_member/1
      },
      %BenchmarkFunction{
        name: "Recursive member",
        function: &recursion_member/1
      }
    ]
  end

  @impl true
  def run_count, do: 5

  @impl true
  def input_generator(index) do
    input_count = [100_000, 200_000, 500_000, 1_000_000, 2_000_000] |> Enum.at(index)
    input = 1..input_count |> Enum.shuffle()

    {input_count,
     %{
       to_find: Enum.random(input),
       input: input
     }}
  end

  def enum_member(%{
        to_find: to_find,
        input: input
      }) do
    Enum.member?(input, to_find)
  end

  def recursion_member(%{to_find: to_find, input: input}) do
    do_find_member_recursively(to_find, input)
  end

  defp do_find_member_recursively(_, []) do
    false
  end

  defp do_find_member_recursively(to_find, [to_find | _rest]) do
    true
  end

  defp do_find_member_recursively(to_find, [_not_to_find | rest]) do
    do_find_member_recursively(to_find, rest)
  end
end
