defmodule Execd.Svc.Runner.Supervisor do
  @moduledoc false

  use Supervisor

  @procname :runner_supervisor

  def start_link([command: _cmd] = args) do
    Supervisor.start_link(__MODULE__, args, name: @procname)
  end

  def start_link(_init_arg) do
    Supervisor.start_link(__MODULE__, [command: ""], name: @procname)
  end

  @impl true
  def init([command: _cmd] = args) do
    children = [
      {Execd.Svc.Runner.Worker, args}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
