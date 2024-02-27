defmodule Formin.Svc.Runner.Writer do

  @moduledoc "Command Writer"

  use GenServer

  alias Formin.Util

  @procname :runner_writer

  # ----- api

  def output(:logfile, path, json) do
    {:ok, file} = File.open(path, [:append])
    IO.write(file, json)
    File.close(file)
  end

  def output(:fifo, _path, _json) do
    :ok
  end

  def output(:amqp, _path, _json) do
    :ok
  end

  def output(:tcp, _path, _json) do
    :ok
  end

  def output(:socket, _path, _json) do
    :ok
  end

  def output(_, _path, _json) do
    :ok
  end

  # ----- startup

  @doc false
  def start_link([command: cmd]) do
    Util.IO.puts(~s[Starting Runner (cmd = "#{cmd}")])
    GenServer.start_link(__MODULE__, cmd, name: @procname)
  end

  def start_link(_) do
    Util.IO.puts("Starting Runner (no command)")
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

  def bash("") do
    :ok
  end

  def bash(cmd) do
    args = ["-c", cmd]
    System.cmd("bash", args)
  end

  def bash("", _data) do
    :ok
  end

  def bash(cmd, data) do
    newcmd = String.replace(cmd, "@data", data)
    bash(newcmd)
  end
end

