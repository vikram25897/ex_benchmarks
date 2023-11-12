defmodule Mix.Tasks.Benchmarks do
  @moduledoc "The hello mix task: `mix help run_benchmakrs_and_generate_html`"
  require Logger
  use Mix.Task

  alias ExBenchmarks.BenchmarkRunner.RunAll

  @template_file_path Path.join(__DIR__, "output_template.html.eex")

  @impl Mix.Task
  def run(command_line_args) do
    Application.ensure_all_started([:briefly, :telemetry])
    Bandit.Clock.start_link([])
    Faker.start()

    (command_line_args ++ ["mix.exs"])
    |> ElixirServer.Validator.validate()
    |> case do
      %{only_generate: true, output: output} ->
        generate_html(output)
        Logger.info("Output html written to #{output}")

      %{only_generate: false, host: host, port: port} ->
        start_webserver(host, port)
    end
  end

  def generate_html(output) do
    result = RunAll.run_benchmarks()
    system_info = get_system_info()

    generated_html =
      EEx.eval_file(@template_file_path, assigns: [result: result, system: system_info])

    File.write!(output, generated_html)
  end

  def start_webserver(host, port) do
    path = Briefly.create!(extname: ".html")
    generate_html(path)

    handle_webserver_response(
      ElixirServer.Webserver.start(%{
        host: host,
        port: port,
        entrypoint: path
      })
    )
  end

  defp handle_webserver_response({:ok, _} = _response) do
    receive do
      {:server_terminated, message} ->
        IO.puts("Server terminated due to: #{message}")
    end
  end

  defp handle_webserver_response({:error, error}) do
    Logger.error(error)
  end

  def get_system_info do
    Benchee.init()
    |> Benchee.system()
    |> Benchee.collect()
    |> Benchee.statistics()
    |> Map.get(:system)
  end
end
