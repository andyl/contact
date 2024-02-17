defmodule Execd.Svc.Httpd.Router do
  @moduledoc false

  use Plug.Router, init_mode: :runtime

  require Logger

  plug(:match)
  plug(:dispatch)
  plug Plug.Parsers, parsers: [:urlencoded]

  get "/" do
    send_resp(conn, 200, ":ok")
  end

  post "/submit" do
    data = conn.params

    dbg(data)

    send_resp(conn, 200, ":form-data-ok")
  end

  match _ do
    Logger.error("File not found: #{conn.request_path}")

    send_resp(conn, 404, "NOT FOUND")
  end

end
