defmodule ExBenchmarks.RustSort do
  @moduledoc false
  use Rustler,
    otp_app: :ex_benchmarks,
    crate: :sort_interface

  def parallel_sort(_arg1), do: :erlang.nif_error(:nif_not_loaded)

  def glide_sort(_arg1), do: :erlang.nif_error(:nif_not_loaded)

  def normal_sort(_arg1), do: :erlang.nif_error(:nif_not_loaded)
end
