defmodule Formin.Cli.Route do

  defstruct method: "",
            path: "",
            actions: []

  alias Formin.Cli.Route

  # post:contact[log=path;fifo=path],post:checklist[log=path]
  # errors:
  # - no actions
  # - no method
  # - no path

  def parse("") do
    []
  end

  def parse(input) do
    input
    |> String.split(",")
  end

  def handle_route("") do
    [""]
  end

  def handle_route(string) do
    [[_string, method, path, actions]] =
      ~r/(.*):(.*)\[(.*)\]/
      |> Regex.scan(string)

    %Route{
      method: method,
      path: path,
      actions: handle_actions(actions)
    }
  end

  def handle_actions(string) do
    string
    |> String.split(";")
    |> Enum.map(fn str -> String.split(str, "=") end)
    |> Enum.map(fn [key, val] -> {String.to_atom(key), val} end)
  end
end
