defmodule Mix.Tasks.Execd.Server do
  @shortdoc "Starts the server"

  @moduledoc "Starts the server"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    Application.put_env(:execd, :server, true)
    Application.put_env(:execd, :command, set_cmd(args))
    Mix.Task.run("app.start", ["--preload-modules"])
    Mix.Tasks.Run.run(["--no-halt"])
  end

  defp set_cmd(_args) do
    {"echo", []}
  end

end
