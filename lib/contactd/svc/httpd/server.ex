defmodule Contactd.Svc.Httpd.Server do

  @moduledoc false

  alias Contactd.Svc.Httpd.Router
  alias Contactd.Util

  def child_spec(_) do
    Util.IO.puts("Starting FTS Httpd on https://localhost:5001")
    Supervisor.child_spec(
      {Bandit, scheme: :http, plug: Router, port: 5001},
      []
    )
  end

end

