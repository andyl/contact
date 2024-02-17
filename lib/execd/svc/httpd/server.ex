defmodule Execd.Svc.Httpd.Server do

  @moduledoc false

  alias Execd.Svc.Httpd.Router
  alias Execd.Util

  def child_spec(_) do
    Util.IO.puts("Starting Httpd on https://localhost:5001")
    Supervisor.child_spec(
      {Bandit, scheme: :http, plug: Router, port: 5001},
      []
    )
  end

end

