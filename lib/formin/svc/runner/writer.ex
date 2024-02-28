defmodule Formin.Svc.Runner.Writer do
  @moduledoc "Command Writer"

  use GenServer

  # alias Formin.Util

  require Logger

  @procname :runner_writer

  # ----- startup

  def start_link(_) do
    GenServer.start_link(__MODULE__, "", name: @procname)
  end

  @doc false
  def init(_) do
    {:ok, %{}}
  end

  # ----- api

  def flush do
    GenServer.call(@procname, :rw_flush)
    :ok
  end

  def output(:file, path, json) do
    GenServer.cast(@procname, {:rw_file, path, json})
    :ok
  end

  def output(:logger, pattern, json) do
    GenServer.cast(@procname, {:rw_logger, pattern, json})
    :ok
  end

  def output(:stdout, pattern, json) do
    GenServer.cast(@procname, {:rw_stdout, pattern, json})
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

  # ----- callbacks

  def handle_call(:rw_flush, _caller, state) do
    {:reply, :ok, state}
  end

  def handle_cast({:rw_stdout, pattern, json}, state) do
    regex = Regex.compile!(pattern)
    if String.match?(json, regex) do
      IO.puts(json)
    end
    {:noreply, state}
  end

  def handle_cast({:rw_file, path, json}, state) do
    {:ok, file} = File.open(path, [:append])
    IO.write(file, json)
    File.close(file)
    {:noreply, state}
  end

  def handle_cast({:rw_logger, pattern, json}, state) do
    regex = ~r/#{pattern}/
    if String.match?(json, regex) do
      Logger.info(json)
    end
    {:noreply, state}
  end

end
