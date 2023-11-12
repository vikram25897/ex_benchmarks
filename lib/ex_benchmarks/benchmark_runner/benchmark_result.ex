defmodule ExBenchmarks.BenchmarkRunner.BenchmarkResult do
  @moduledoc false
  alias ExBenchmarks.BenchmarkRunner.BenchmarkConfig
  alias ExBenchmarks.BenchmarkRunner.IndividualFunctionResult

  defstruct [
    :input_sizes,
    :functions_result,
    :config
  ]

  @type t :: %__MODULE__{
          input_sizes: list(integer()),
          functions_result: list(IndividualFunctionResult.t()),
          config: BenchmarkConfig.t()
        }

  @spec generate_empty_result(BenchmarkConfig.t()) ::
          t()
  def generate_empty_result(%BenchmarkConfig{} = config) do
    %__MODULE__{
      input_sizes: [],
      functions_result:
        1..length(config.functions)
        |> Enum.map(fn _ ->
          %IndividualFunctionResult{
            average: [],
            ips: [],
            median: [],
            percentiles: [],
            mode: []
          }
        end),
      config: config
    }
  end

  @spec append_iteration_result(
          Benchee.Suite.t(),
          t(),
          integer()
        ) :: ExBenchmarks.BenchmarkRunner.BenchmarkResult.t()
  def append_iteration_result(
        %Benchee.Suite{
          scenarios: scenarios
        },
        %__MODULE__{} = base_result,
        input_size
      ) do
    %__MODULE__{
      input_sizes: [input_size] ++ base_result.input_sizes,
      config: base_result.config,
      functions_result:
        0..(length(base_result.config.functions) - 1)
        |> Enum.map(fn index ->
          IndividualFunctionResult.append_iteration_result(
            Enum.at(base_result.functions_result, index),
            Enum.at(scenarios, index)
          )
        end)
    }
  end
end
