defmodule Formin.Pom.CliTest do

  use ExUnit.Case

  import ExUnit.CaptureIO

  alias Formin.Pom.Cli

  describe "#config/0" do
    test "returns data" do
      assert Cli.config()
    end
  end

  describe "#version/0" do
    test "returns a value" do
      assert Cli.version()
    end
  end

  describe "#parse/1 misc" do
    test "parses empty argv" do
      assert Cli.parse([])
    end

    test "parses version flag" do
      result = capture_io(fn -> Cli.parse(~w[--version]) end)
      assert result =~ "formin"
    end

    test "parses help flag" do
      result = capture_io(fn -> Cli.parse(~w[--help]) end)
      assert result =~ "formin"
    end

    test "parses shortport option" do
      result = Cli.parse(~w[-p 2000])
      assert result.options.port == 2000
    end

    test "parses longport option" do
      result = Cli.parse(~w[--port 2000])
      assert result.options.port == 2000
    end
  end


  describe "#parse/1" do
    test "actions" do
      result = Cli.parse(~w(--actions post:path[fifo=file])) |> IO.inspect()
      assert result
    end
  end

end

