defmodule Formin.Svc.Runner.Worker do

  @moduledoc "Command Runner"

  @procname :runner_worker

  use GenServer

  alias Formin.Util

  # ----- api

  @doc "Run a random command"
  def run(cmd) do
    GenServer.call(@procname, {:rw_run, cmd})
  end

  def post(data) do
    GenServer.call(@procname, {:rw_post, data})
  end

  def setcmd(cmd) do
    GenServer.call(@procname, {:rw_setcmd, cmd})
  end

  def getcmd do
    GenServer.call(@procname, :rw_getcmd)
  end

  # ----- startup

  @doc false
  def start_link([command: cmd]) do
    Util.IO.puts(~s[Starting Worker (cmd = "#{cmd}")])
    GenServer.start_link(__MODULE__, cmd, name: @procname)
  end

  def start_link(_) do
    Util.IO.puts("Starting Worker (no command)")
    GenServer.start_link(__MODULE__, "", name: @procname)
  end

  @doc false
  def init(cmd) do
    {:ok, %{cmd: cmd}}
  end

  # ----- callbacks

  def handle_call(:rw_getcmd, _from, %{cmd: cmd} = state) do
    {:reply, cmd, state}
  end

  def handle_call({:rw_setcmd, cmd}, _from, _state) do
    {:reply, :ok, %{cmd: cmd}}
  end

  def handle_call({:rw_run, cmd}, _from, state) do
    bash(cmd)
    {:reply, :ok, state}
  end

  def handle_call({:rw_post, data}, _from, %{cmd: cmd} = state) do
    bash(cmd, data)
    {:reply, :ok, state}
  end

  # ----- helpers

  # TBD

end

