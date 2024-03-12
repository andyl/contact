defmodule Mix.Tasks.Formin.Server do

  @moduledoc "Starts the server"

  use Mix.Task

  @impl Mix.Task
  def run(args) do

    cli_opts = Formin.Pom.Cli.main(args)

    Application.put_env(:formin, :port, cli_opts.options.port)
    Application.put_env(:formin, :server, true)
    Mix.Task.run("app.start", ["--preload-modules"])

    cli_opts
    |> Formin.Svc.Opts.set_state()
    |> IO.inspect(label: "CRAZED")

    Mix.Tasks.Run.run(["--no-halt"])
  end

end

