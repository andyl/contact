defmodule Mix.Tasks.Srvr do
  @shortdoc "Starts the server"

  @moduledoc "Starts the server"

  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    Application.put_env(:contactd, :server, true)
    Mix.Task.run("app.start", ["--preload-modules"])
    Mix.Tasks.Run.run(["--no-halt"])
  end

end
