defmodule ExBenchmarks.BenchmarkRunner.RunOne do
  @moduledoc false
  alias ExBenchmarks.BenchmarkRunner.{
    BenchmarkConfig,
    BenchmarkFunction,
    BenchmarkResult
  }

  @spec run_one(BenchmarkConfig.t()) ::
          BenchmarkResult.t()
  def run_one(%BenchmarkConfig{} = config) do
    benchmark_result = BenchmarkResult.generate_empty_result(config)
    run_iteration(config, config.run_count - 1, benchmark_result)
  end

  defp run_iteration(_, index, benchmark_result) when index < 0 do
    benchmark_result
  end

  defp run_iteration(config, index, benchmark_result) do
    {input_size, input} = config.input_generator.(index)

    benchmark_result =
      [
        time: 5,
        print: %{
          benchmarking: false,
          configuration: false,
          fast_warning: false
        }
      ]
      |> Benchee.init()
      |> Benchee.system()
      |> append_benchmarks(config.functions, input)
      |> Benchee.collect()
      |> Benchee.statistics()
      |> BenchmarkResult.append_iteration_result(benchmark_result, input_size)

    run_iteration(config, index - 1, benchmark_result)
  end

  defp append_benchmarks(benchee, functions, input) do
    Enum.reduce(functions, benchee, fn %BenchmarkFunction{
                                         function: function,
                                         name: name
                                       },
                                       benchee ->
      Benchee.benchmark(benchee, name, fn -> function.(input) end)
    end)
  end
end
