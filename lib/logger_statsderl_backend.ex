defmodule LoggerStatsderlBackend do
  use GenEvent

  @moduledoc """
  backend for Logger that sends counters to graphite using statsderl
  """

  def init(__MODULE__) do
    {:ok, configure([])}
  end

  def handle_call({:configure, opts}, _state) do
    {:ok, :ok, configure(opts)}
  end


  def handle_event({_level, gl, _event}, state) when node(gl) != node() do {:ok, state} end

  def handle_event({level, _gl, _event}, state) do
    if meet_level?(level, state.level) do
      key = state.prefix <> :erlang.atom_to_binary(level, :latin1)
      :statsderl.increment(key, 1, 1)
    end
    {:ok, state}
  end



  defp meet_level?(lvl, min) do
    Logger.compare_levels(lvl, min) != :lt
  end

  defp configure(opts) do
    config =
      Application.get_env(:logger, __MODULE__, [])
      |> Keyword.merge(opts)
    Application.put_env(:logger, __MODULE__, config)

    prefix = case Keyword.get(config, :prefix, false) do
      false -> ""
      value -> String.strip(value, ?.) <> "."
    end

    %{
      level: Keyword.get(config, :level, :error),
      prefix: prefix,
    }
  end

end
