defmodule Mix.Tasks.Execd.Server do
  @shortdoc "Starts the server"

  @moduledoc "Starts the server"

  use Mix.Task

  @impl Mix.Task
  def run(cmd) when is_binary(cmd) do
    Application.put_env(:execd, :server, true)
    Application.put_env(:execd, :command, cmd)
    Mix.Task.run("app.start", ["--preload-modules"])
    Mix.Tasks.Run.run(["--no-halt"])
  end

  @impl Mix.Task
  def run([cmd]) when is_binary(cmd) do
    run(cmd)
  end

  def run(_) do
    run("")
  end

end
