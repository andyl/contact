defmodule Mix.Tasks.Formin.Server do
  @shortdoc "Starts the server"

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
    |> Formin.Svc.Opts.set_state()

    IO.puts("BBB")
    Mix.Tasks.Run.run(["--no-halt"])
  end

  # @impl Mix.Task
  # def run([cmd]) when is_binary(cmd) do
  #   IO.inspect(cmd, label: "XXX")
  #   run(cmd)
  # end
  #
  # def run(_) do
  #   run("")
  # end

end
