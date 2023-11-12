defmodule ExBenchmarks.BenchmarkRunner.BenchmarkConfig do
  @moduledoc false
  alias ExBenchmarks.BenchmarkRunner.BenchmarkFunction

  defstruct [
    :name,
    :run_count,
    :input_generator,
    :functions,
    :module
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          run_count: integer(),
          input_generator: fun(),
          functions: list(BenchmarkFunction.t()),
          module: module()
        }

  @spec extract_config(module()) :: ExBenchmarks.BenchmarkRunner.BenchmarkConfig.t()
  def extract_config(module) do
    %__MODULE__{
      name: module.name(),
      run_count: module.run_count(),
      input_generator: &module.input_generator/1,
      functions: module.functions(),
      module: module
    }
  end
end
