defmodule Formin.Svc.Httpd.Server do

  @moduledoc false

  alias Formin.Svc.Httpd.Router
  alias Formin.Util

  def child_spec(_) do
    port = Application.get_env(:formin, :port)

    Util.IO.puts("Starting Httpd on port #{port}")
    Supervisor.child_spec(
      {Bandit, scheme: :http, plug: Router, port: port},
      []
    )
  end

end

