# ExBenchmarks

## Small collection of benchmarks

### Running locally

* Rust and `cargo` should be installed on system
* Run `MIX_ENV=prod mix release` to build release
* Run `_build/prod/rel/ex_benchmarks/bin/ex_benchmarks eval "ExBenchmarks.ReleaseTasks.generate_html()"` to generate html or
* Run `_build/prod/rel/ex_benchmarks/bin/ex_benchmarks eval "ExBenchmarks.ReleaseTasks.run_server()"` to run HTTP server after running benchmarks. Access results at [localhost:4000](http://localhost:4000)

