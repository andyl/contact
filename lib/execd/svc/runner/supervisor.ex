defmodule Execd.Svc.Runner.Supervisor do
  @moduledoc false

  use Supervisor

  @procname :runner_supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: @procname)
  end

  @impl true
  def init(_init_arg) do
    children = [
      Execd.Svc.Runner.Worker
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
