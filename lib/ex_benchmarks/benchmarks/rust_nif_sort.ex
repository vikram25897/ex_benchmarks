defmodule ExBenchmarks.Benchmarks.RustNifSort do
  @moduledoc false
  @behaviour ExBenchmarks.Benchmarks.Behaviour

  alias ExBenchmarks.BenchmarkRunner.BenchmarkFunction
  alias ExBenchmarks.RustSort

  @impl true
  def name, do: "Rust NIF Sorting"

  @impl true
  def functions do
    [
      %BenchmarkFunction{
        name: "Enum.sort",
        function: &elixir_sort/1
      },
      %BenchmarkFunction{
        name: "Rust normal sort",
        function: &rust_normal_sort/1
      },
      %BenchmarkFunction{
        name: "Rust parallel sort",
        function: &rust_parallel_sort/1
      },
      %BenchmarkFunction{
        name: "Rust glide sort",
        function: &rust_glide_sort/1
      }
    ]
  end

  @impl true
  def run_count, do: 5

  @impl true
  def input_generator(index) do
    input_count = [100_000, 200_000, 500_000, 1_000_000, 2_000_000] |> Enum.at(index)
    input = 1..input_count |> Enum.shuffle()

    {input_count, input}
  end

  def elixir_sort(input) do
    Enum.sort(input)
  end

  def rust_normal_sort(input) do
    RustSort.normal_sort(input)
  end

  def rust_parallel_sort(input) do
    RustSort.parallel_sort(input)
  end

  def rust_glide_sort(input) do
    RustSort.glide_sort(input)
  end
end
