defmodule Formin.Svc.Httpd.Router do
  @moduledoc false

  # Formin Outputs
  # - [ ] log `path`
  # - [ ] fifo `path`
  # - [ ] amqp `host:port/queue`
  # - [ ] tcp `host:port`
  # - [ ] socket `path`
  #
  # Format Routes
  # - [ ] post/contact[log=path;fifo=path],post/checklist[log=path]
  #
  # Configuration
  # - [ ] command-line options
  # - [ ] environment variables
  # - [ ] yaml file
  # - [ ] elixir configuration

  use Plug.Router, init_mode: :runtime

  alias Formin.Svc.Http.CorsPlug
  alias Formin.Event

  require Logger

  plug(Plug.Parsers, parsers: [:urlencoded])
  plug(CorsPlug)
  plug(:match)
  plug(:dispatch)

  get "/favicon.ico" do
    send_resp(conn, 200, "")
  end

  get "/" do
    send_resp(conn, 200, "ok")
  end

  get _ do
    {code, msg} = Event.process(:get, conn.request_path, conn.params)
    send_resp(conn, code, msg)
  end

  post _ do
    {code, msg} = Event.process(:post, conn.request_path, conn.params)
    send_resp(conn, code, msg)
  end

  put _ do
    {code, msg} = Event.process(:post, conn.request_path, conn.params)
    send_resp(conn, code, msg)
  end

  patch _ do
    {code, msg} = Event.process(:post, conn.request_path, conn.params)
    send_resp(conn, code, msg)
  end

  delete _ do
    {code, msg} = Event.process(:post, conn.request_path, conn.params)
    send_resp(conn, code, msg)
  end

  match _ do
    Logger.error("File not found: #{conn.request_path}")
    send_resp(conn, 404, "NOT FOUND")
  end
end
