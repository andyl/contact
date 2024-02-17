defmodule Execd.Svc.Runner.Worker do

  @moduledoc "Command Runner"

  use GenServer

  alias Execd.Util

  @procname :runner_worker

  # ----- api

  @doc "Run the command"
  def run(cmd, args) do
    GenServer.cast(@procname, {:er_run, cmd, args})
  end

  # ----- startup

  @doc false
  def start_link(args) do
    Util.IO.puts("Starting FTS DB Runner")
    GenServer.start_link(__MODULE__, args, name: @procname)
  end

  @doc false
  def init(_args) do
    {:ok, %{}}
  end

  # ----- callbacks

  def handle_cast({:er_run, cmd, args}, state) do
    IO.inspect({cmd, args})
    {:noreply, state}
  end

  # ----- helpers

end

