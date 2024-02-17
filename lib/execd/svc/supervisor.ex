defmodule Execd.Svc.Supervisor do

  @moduledoc false

  use Supervisor

  # @dir "/home/aleak/util/org"
  @procname :svc_supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: @procname)
  end

  @impl true
  def init(_init_arg) do
    if Application.get_env(:contactd, :server) do
      children = [
        {Execd.Svc.Httpd.Server, []}
      ]
      Supervisor.init(children, strategy: :one_for_one)
    else
      :ignore
    end
  end

end
