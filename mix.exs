defmodule ExBenchmarks.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_benchmarks,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        plt_add_apps: [:mix],
        ignore_warnings: ".dialyzer_ignore.exs"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_server, "~> 0.1.0"},
      {:benchee, "~> 1.0"},
      {:briefly, "~> 0.4.0"},
      {:jason, "~> 1.4"},
      {:rustler, "~> 0.30.0"},
      {:faker, "~> 0.17.0"},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false},
      {:credo, "~> 1.7", only: [:dev], runtime: false}
    ]
  end
end
