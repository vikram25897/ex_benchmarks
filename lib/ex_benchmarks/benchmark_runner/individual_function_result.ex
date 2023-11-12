defmodule ExBenchmarks.BenchmarkRunner.IndividualFunctionResult do
  @moduledoc false
  defstruct [
    :average,
    :ips,
    :median,
    :percentiles,
    :mode
  ]

  @type t :: %__MODULE__{
          average: list(float()),
          ips: list(float()),
          median: list(float()),
          percentiles: list(map()),
          mode: list(float())
        }

  @spec append_iteration_result(
          t(),
          Benchee.Scenario.t()
        ) :: t()
  def append_iteration_result(%__MODULE__{} = current, %Benchee.Scenario{
        run_time_data: %Benchee.CollectionData{
          statistics: %Benchee.Statistics{} = statistics
        }
      }) do
    %__MODULE__{
      average: flatten([statistics.average] ++ current.average),
      ips: flatten([statistics.ips] ++ current.ips),
      median: flatten([statistics.median] ++ current.median),
      percentiles: flatten([statistics.percentiles] ++ current.percentiles),
      mode: flatten([statistics.mode] ++ current.mode)
    }
  end

  defp flatten(list, output \\ [])
  defp flatten([], output), do: output

  defp flatten([h | t], output) when is_list(h) do
    average = Enum.sum(h) / length(h)
    flatten(t, output ++ [average])
  end

  defp flatten([h | t], output) do
    flatten(t, output ++ [h])
  end
end
