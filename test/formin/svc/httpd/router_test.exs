defmodule Formin.Svc.Httpd.RouterTest do
  use ExUnit.Case
  import Plug.Test

  alias Formin.Svc.Httpd.Router

  @opts Router.init([])

  describe "/" do
    test "GET /" do
      conn =
        conn(:get, "/")
        |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == ":ok"
    end
  end

  # describe "/submit" do
  #   test "POST /submit with form data" do
  #     simulated_form_data = "name=John&age=30"
  #
  #     conn =
  #       conn(:post, "/submit", simulated_form_data)
  #       |> Plug.Conn.put_req_header("content-type", "application/x-www-form-urlencoded")
  #       |> Router.call(@opts)
  #
  #     assert conn.state == :sent
  #     assert conn.status == 200
  #     assert conn.resp_body == ":form-data-ok"
  #     assert conn.params["age"] == "30"
  #     assert conn.params["name"] == "John"
  #   end
  # end
end

