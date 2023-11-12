defmodule ExBenchmarks.Benchmarks.Behaviour do
  @moduledoc false
  alias ExBenchmarks.BenchmarkRunner.BenchmarkFunction

  @callback name() :: String.t()
  @callback run_count() :: integer()
  @callback input_generator(index :: integer()) :: {integer(), any()}
  @callback functions() :: list(BenchmarkFunction.t())
end
