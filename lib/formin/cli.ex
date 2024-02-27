defmodule Formin.Cli do
  @app_version Mix.Project.config()[:version]

  def main(argv) do
    Optimus.new!(
      name: "formin",
      description: "Input server for HTML form data",
      version: @app_version,
      about: "Input server for HTML form data",
      allow_unknown_args: false,
      parse_double_dash: true,
      args: [],
      flags: [
        help: [
          short: "-h",
          long: "--help",
          help: "HELP",
        ],
        version: [
          short: "-v",
          long: "--version",
          help: "Version",
        ],
      ],
      options: [
        port: [
          short: "-p",
          long: "--port",
          help: "Listener port",
          parser: fn s -> s end,
          required: false,
          default: 3303
        ],
        routes: [
          short: "-r",
          long: "--routes",
          help: "listener routes",
          parser: fn s -> s end,
          required: false,
          default: []
        ],
        config: [
          short: "-c",
          long: "--config",
          help: "config yaml file",
          parser: fn s -> s end,
          required: false,
          default: ""
        ]
      ]
    )
    |> Optimus.parse!(argv)
    |> IO.inspect()
  end
end
