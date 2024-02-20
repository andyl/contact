defmodule Formin.Svc.Httpd.Router do
  @moduledoc false

  use Plug.Router, init_mode: :runtime

  alias Formin.Svc.Runner.Worker

  require Logger

  plug Plug.Parsers, parsers: [:urlencoded]
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, ":ok")
  end

  post "/submit" do
    conn.params
    |> Jason.encode!()
    |> Worker.post()

    send_resp(conn, 200, ":form-data-ok")
  end

  match _ do
    Logger.error("File not found: #{conn.request_path}")

    send_resp(conn, 404, "NOT FOUND")
  end

end
