defmodule Formin.Svc.Writer do

  @moduledoc "Output to Stdout"

  @procname :formin_writer

  use GenServer
  alias Formin.Util

  # ----- api

  def event(msg) do
    GenServer.cast(@procname, {:fw_event, msg})
  end

  def set_state(newstate) do
    GenServer.call(@procname, {:fw_setstate, newstate})
  end

  def flush do
    GenServer.call(@procname, :fw_flush)
  end

  # ----- startup

  @doc false
  def start_link(args) do
    Util.IO.puts(~s[Writer])
    GenServer.start_link(__MODULE__, args, name: @procname)
  end

  @doc false
  def init(args) do
    {:ok, args}
  end

  # ----- callbacks

  def handle_cast({:fw_event, msg}, _from, state) do
    process_event(msg, state)
    {:noreply, state}
  end

  def handle_call({:fw_setstate, newstate}, _state) do
    {:reply, :ok, newstate}
  end

  def handle_call(:fw_flush, state) do
    {:reply, :ok, state}
  end

  # ----- helpers

  def process_event(msg, state) do
    IO.inspect({msg, state}, label: "PROCESS_EVENT")
  end

end
