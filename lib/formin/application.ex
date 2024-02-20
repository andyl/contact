defmodule Formin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @procname :formin

  @impl true
  def start(_type, _args) do
    children = [
      Formin.Svc.Supervisor
    ]

    opts = [strategy: :one_for_one, name: @procname]
    Supervisor.start_link(children, opts)
  end

end
