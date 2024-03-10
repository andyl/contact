defmodule Formin.Cli.Route do


  defstruct method: "",
            path: "",
            actions: []

  # post:contact[log=path;fifo=path],post:checklist[log=path]
  # errors:
  # - no actions
  # - no method
  # - no path
  def parse(input) do
    input
    |> String.split(",")
  end

  def extract(string) do
    string
  end

end
