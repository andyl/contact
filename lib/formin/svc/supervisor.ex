defmodule Formin.Svc.Supervisor do

  @moduledoc false

  use Supervisor

  @procname :svc_supervisor

  def start_link([server: true]) do
    Application.put_env(:formin, :server, true)
    start_link([])
  end

  def start_link(init_args) do
    Supervisor.start_link(__MODULE__, init_args, name: @procname)
  end

  @impl true
  def init(_init_arg) do
    if Application.get_env(:formin, :server) do
      cmd = Application.get_env(:formin, :command) || ""
      children = [
        Formin.Svc.Httpd.Server,
        {Formin.Svc.Runner.Supervisor, [command: cmd]}
      ]
      Supervisor.init(children, strategy: :one_for_one)
    else
      :ignore
    end
  end

end
