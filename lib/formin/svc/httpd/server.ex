defmodule Formin.Svc.Httpd.Server do

  @moduledoc false

  alias Formin.Svc.Httpd.Router
  alias Formin.Util

  def child_spec(_) do
    Util.IO.puts("Starting Httpd on port 5001")
    Supervisor.child_spec(
      {Bandit, scheme: :http, plug: Router, port: 5001},
      []
    )
  end

end

