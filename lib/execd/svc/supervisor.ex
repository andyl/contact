defmodule Execd.Svc.Supervisor do

  @moduledoc false

  use Supervisor

  @procname :svc_supervisor

  def start_link([server: true]) do
    Application.put_env(:execd, :server, true)
    start_link([])
  end

  def start_link(init_args) do
    Supervisor.start_link(__MODULE__, init_args, name: @procname)
  end

  @impl true
  def init(_init_arg) do
    if Application.get_env(:execd, :server) do
      cmd = Application.get_env(:execd, :command) || ""
      children = [
        Execd.Svc.Httpd.Server,
        {Execd.Svc.Runner.Supervisor, [command: cmd]}
      ]
      Supervisor.init(children, strategy: :one_for_one)
    else
      :ignore
    end
  end

end
