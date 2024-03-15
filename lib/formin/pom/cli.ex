defmodule Formin.Pom.Cli do

  @app_version Mix.Project.config()[:version]

  alias Formin.Pom.Action

  def parse(argv) when is_binary(argv) do
    argv
    |> String.split(" ")
    |> parse()
  end

  def parse(argv) do
    case Mix.env() do
      :test ->
        test_halt = fn _code -> :ok end
        config() |> Optimus.parse!(argv, test_halt)
      _ ->
        config() |> Optimus.parse!(argv)
    end
  end

  def version do
    config().version
  end

  def config do
    Optimus.new!(
      name: "formin",
      description: "formin",
      version: @app_version,
      about: "server/router for HTML form data",
      allow_unknown_args: false,
      parse_double_dash: true,
      args: [],
      flags: [],
      options: [
        port: [
          value_name: "PORT",
          short: "-p",
          long: "--port",
          help: "Listener port",
          parser: fn s -> {:ok, String.to_integer(s)} end,
          required: false,
          default: 3303
        ],
        config: [
          value_name: "CONFIG",
          short: "-c",
          long: "--config",
          help: "config yaml file",
          parser: fn s -> {:ok, s} end,
          required: false,
          default: ""
        ],
        actions: [
          value_name: "ACTIONS",
          short: "-a",
          long: "--actions",
          help: "server actions",
          parser: fn s -> {:ok, Action.parse(s)} end,
          required: false,
          default: []
        ],
      ]
    )
  end

end
