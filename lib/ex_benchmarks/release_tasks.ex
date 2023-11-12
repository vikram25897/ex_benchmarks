defmodule ExBenchmarks.ReleaseTasks do
  @moduledoc false
  alias Mix.Tasks.Benchmarks

  @default_output_path Path.join(File.cwd!(), "output.html")

  def run_server do
    Application.ensure_all_started([:briefly, :telemetry])
    Bandit.Clock.start_link([])
    Faker.start()
    Benchmarks.start_webserver(:loopback, 4000)
  end

  def generate_html do
    Application.ensure_all_started([:briefly, :telemetry])
    Bandit.Clock.start_link([])
    Faker.start()
    Benchmarks.generate_html(@default_output_path)
  end
end
