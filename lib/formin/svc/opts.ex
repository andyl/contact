defmodule Formin.Svc.Opts do

  @moduledoc """
  Options

  Configuration Opts
  - [ ] command-line options
  - [ ] environment variables
  - [ ] yaml file
  - [ ] elixir configuration

  Opts
  - [ ] options for dev, test & prod
  - [ ] options for environment variables
  - [ ] options for command line
  - [ ] options for yaml file
  - [ ] Add tests for options
  """

  @procname :svc_opts

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
    ensure_started()
    Agent.update(@procname, fn _ -> newstate end)
    get_state()
  end

  def clear_state do
    ensure_started()
    Agent.update(@procname, fn _ -> %{} end)
  end

  def merge_state(newstate) do
    ensure_started()
    Agent.update(@procname, fn oldstate -> Map.merge(oldstate, newstate) end)
  end

  def get_state do
    ensure_started()
    Agent.get(@procname, &(&1))
  end

  # ----- startup

  def start_link(initial_state \\ []) do
    Agent.start_link(fn -> initial_state end, name: @procname)
  end

  # ----- helpers

  defp ensure_started do
    unless Process.whereis(@procname), do: start_link([])
  end

end
