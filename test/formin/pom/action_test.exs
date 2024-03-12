defmodule Formin.Pom.ActionTest do

  use ExUnit.Case

  alias Formin.Pom.Action

  describe "#parse/1" do
    test "empty string" do
      assert Action.parse("") == []
    end
  end

  describe "#handle_route/1" do
    test "with blank string" do
      assert Action.handle_route("") == [""]
    end

    test "with full-blown string" do
      string = "post:contact[log=path;fifo=path]"
      result = Action.handle_route(string)
      assert result.method == "post"
      assert result.path == "contact"
      assert result.actions[:log] == "path"
      assert result.actions[:fifo] == "path"
    end

  end

end

