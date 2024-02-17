defmodule Contactd.Svc.Httpd.Router do
  @moduledoc false

  use Plug.Router, init_mode: :runtime

  # alias Contactd.Svc.Manager

  require Logger

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, ":ok")
  end

  get "/all" do
    send_resp(conn, 200, gen_all())
  end

  # /search?query='my query'
  get "/search" do
    query = Plug.Conn.fetch_query_params(conn).query_params["query"]

    result = case query do
      nil -> "[]"
      _ -> gen_response(query)
    end

    send_resp(conn, 200, result)
  end

  # /search_nvim?query='my query'
  get "/search_nvim" do
    query = Plug.Conn.fetch_query_params(conn).query_params["query"]

    Contactd.Util.IO.puts("search_nvim: #{query}")

    result = case query do
      nil -> "[]"
      _ -> gen_nvim_response(query)
    end

    send_resp(conn, 200, result)
  end

  match _ do
    Logger.error("File not found: #{conn.request_path}")

    send_resp(conn, 404, "NOT FOUND")
  end

  # defp retain_at(list, index_list) when is_list(index_list) do
  #   list
  #   |> Enum.with_index()
  #   |> Enum.reject(fn {_, idx} -> idx not in index_list end)
  #   |> Enum.map(fn {elem, _} -> elem end)
  # end

  defp gen_response(query) do
    query
    |> clean_query()
    # |> Manager.search()
    # |> Jason.encode!()
  end

  defp gen_nvim_response(query) do
    query
    |> clean_query()
    # |> Manager.search()
    # |> Enum.map(fn list -> package_elements(list) end)
    # |> prepend_position()
    # |> Jason.encode!()
  end

  # defp package_elements([doctitle, sectitle, path, startline]) do
  #   subpath = last_two_segments(path)
  #   [doctitle, sectitle, path, subpath, startline]
  # end

  # defp last_two_segments(path) do
  #   segments = String.split(path, "/")
  #   case Enum.take(segments, -2) do
  #     [] -> ""
  #     last_two_segments -> Enum.join(last_two_segments, "/")
  #   end
  # end

  def prepend_position(list_of_lists) do
    Enum.with_index(list_of_lists, 1)
    |> Enum.map(fn {sub_list, index} -> [index] ++ sub_list end)
  end

  defp clean_query(query) do
      query
      |> String.replace("\"", "")
      |> String.replace("'", "")
      |> String.replace("\\", "")
  end

  defp gen_all do
    # Manager.select_all()
    # |> Jason.encode!()
    :ok
  end
end
