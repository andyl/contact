defmodule Formin.Pom.Action do

  @moduledoc """
  Cfg Action

  post:contact[log=path;fifo=path],post:checklist[log=path]

  - log    `path`            | log file
  - fifo   `path`            | named pipe (fifo)
  - amqp   `host:port/queue` | rabbit mq
  - tcp    `host:port`       | tcp server
  - socket `path`            | linux socket
  - logger `regex`           | log file
  - stdout `regex`           | stdout
  - shell  `path`            | run shell script

  errors:
  - no actions
  - no method
  - no path
  """

  defstruct method: "",
            path: "",
            actions: []

  alias Formin.Pom.Action

  def parse("") do
    []
  end

  def parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&(handle_route(&1)))
  end

  def handle_route("") do
    [""]
  end

  def handle_route(string) do
    [[_string, method, path, actions]] =
      ~r/(.*):(.*)\[(.*)\]/
      |> Regex.scan(string)

    %Action{
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
