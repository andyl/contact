defmodule Mix.Tasks.Formin.Server do

  @moduledoc "Starts the server"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    IO.inspect(args, label: "ZZZ")
    Application.put_env(:formin, :server, true)
    IO.puts("AAA")
    Mix.Task.run("app.start", ["--preload-modules"])

    args
    |> Formin.Pom.Cli.main()
    |> IO.inspect(label: "CRAZED")
    |> Formin.Svc.Opts.set_state()

    Formin.Svc.Opts.get_state()
    |> IO.inspect(label: "MILLION")

    IO.puts("BBB")
    Mix.Tasks.Run.run(["--no-halt"])
  end

end

