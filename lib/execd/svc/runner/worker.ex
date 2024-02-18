defmodule Execd.Svc.Runner.Worker do

  @moduledoc "Command Runner"

  use GenServer

  alias Execd.Util

  @procname :runner_worker

  # ----- api

  @doc "Run the command"
  def run(cmd, args \\ []) do
    GenServer.cast(@procname, {:rw_run, cmd, args})
  end

  def post(data) do
    GenServer.cast(@procname, {:rw_post, data})
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

  def handle_cast({:rw_run, cmd, args}, state) do
    IO.inspect({cmd, args}, label: "Running ")
    {:noreply, state}
  end

  def handle_cast({:rw_post, data}, state) do
    IO.inspect(data, label: "Posting ")
    {:noreply, state}
  end

  # ----- helpers

end

