defmodule Formin.Cfg.RouteTest do

  use ExUnit.Case

  alias Formin.Cfg.Route

  describe "#parse/1" do
    test "empty string" do
      assert Route.parse("") == []
    end
  end

  describe "#handle_route/1" do
    test "with blank string" do
      assert Route.handle_route("") == [""]
    end

    test "with full-blown string" do
      string = "post:contact[log=path;fifo=path]"
      result = Route.handle_route(string)
      assert result.method == "post"
      assert result.path == "contact"
      assert result.actions[:log] == "path"
      assert result.actions[:fifo] == "path"
    end

  end

end

