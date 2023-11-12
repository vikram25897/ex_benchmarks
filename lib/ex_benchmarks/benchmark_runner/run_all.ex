defmodule ExBenchmarks.BenchmarkRunner.RunAll do
  @moduledoc """
  This module runs all benchmarks that implement `ExBenchmarks.Benchmarks.Behaviour` behaviour
  """
  alias ExBenchmarks.Benchmarks

  alias ExBenchmarks.BenchmarkRunner.{
    BenchmarkConfig,
    BenchmarkResult,
    RunOne
  }

  @benchmarks [
    Benchmarks.EnumMemberVsRecursion,
    Benchmarks.PatternMatchingVsMapGet,
    Benchmarks.ReverseRecursionVsEnumMap,
    Benchmarks.RustNifSort
  ]

  @spec run_benchmarks :: list(BenchmarkResult.t())
  def run_benchmarks do
    @benchmarks
    |> extract_benchmarks_config()
    |> Enum.map(&RunOne.run_one/1)
  end

  defp extract_benchmarks_config(modules_list) do
    Enum.map(modules_list, &BenchmarkConfig.extract_config/1)
  end
end
