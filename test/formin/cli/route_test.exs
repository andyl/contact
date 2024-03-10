defmodule Formin.Cli.RouteTest do

  use ExUnit.Case

  alias Formin.Cli.Route

  describe "Overview" do
    test "with blank string" do
      assert Route
    end
  end

  describe "#extract/1" do
    test "with blank string" do
      assert Route.extract("")
    end
  end

end

