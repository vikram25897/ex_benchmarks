defmodule ExBenchmarks.BenchmarkRunner.BenchmarkFunction do
  @moduledoc false
  defstruct [
    :name,
    :function
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          function: fun()
        }
end
