defmodule Formin.CliTest do

  use ExUnit.Case

  import ExUnit.CaptureIO

  alias Formin.Cli

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

  describe "#main/1" do
    test "parses empty argv" do
      assert Cli.main([])
    end

    test "parses version flag" do
      result = capture_io(fn -> Cli.main(~w[--version]) end)
      assert result =~ "version"
    end

    test "parses help flag" do
      result = capture_io(fn -> Cli.main(~w[--help]) end)
      assert result =~ "formin"
    end

    test "parses shortport option" do
      result = Cli.main(~w[-p 2000])
      result |> IO.inspect()
      IO.puts("ASDF")
      assert result.options.port == 2000
    end

    test "parses longport option" do
      result = Cli.main(~w[--port 2000])
      assert result.options.port == 2000
    end

  end

end
