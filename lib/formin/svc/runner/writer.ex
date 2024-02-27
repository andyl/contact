defmodule Formin.Svc.Runner.Writer do
  @moduledoc "Command Writer"

  use GenServer

  alias Formin.Util

  @procname :runner_writer

  # ----- api

  def output(:logfile, path, json) do
    GenServer.call(@procname, {:wr_logfile, path, json})
    :ok
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

  def start_link(_) do
    Util.IO.puts("Starting Writer")
    GenServer.start_link(__MODULE__, "", name: @procname)
  end

  @doc false
  def init(_) do
    {:ok, %{}}
  end

  # ----- callbacks

  def handle_cast({:wr_logfile, path, json}, state) do
    {:ok, file} = File.open(path, [:append])
    IO.write(file, json)
    File.close(file)
    {:noreply, state}
  end

end
