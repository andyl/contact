defmodule Formin.Cfg.Opts do

  @procname :formin_opts

  use Agent

  # ----- util

  def default_routes do
    %{
      "post/contact" => [
        logfile: "/home/aleak/zz/formin/contact.log"
      ],
      "post/wom" => []
    }
  end

  # ----- api

  def set_state(newstate) do
    Agent.update(@procname, fn _ -> newstate end)
  end

  def clear_state do
    Agent.update(@procname, fn _ -> %{} end)
  end

  def merge_state(newstate) do
    Agent.update(@procname, fn oldstate -> Map.merge(oldstate, newstate) end)
  end

  def get_state do
    Agent.get(@procname, &(&1))
  end

  # ----- startup

  def start_link(initial_state \\ %{}) when is_map(initial_state) do
    Agent.start_link(fn -> initial_state end, name: @procname)
  end

  # ----- helpers

end
