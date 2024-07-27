# test/formin/svc/runner/worker_test.exs
defmodule Formin.Svc.Runner.WorkerTest do

  use ExUnit.Case

  alias Formin.Svc.Runner.Worker
  alias Formin.Util

  describe "#start_link/1" do
    test "using start_link directly" do
      assert {:ok, _pid} = Worker.start_link([])
    end

    test "with start_supervised" do
      assert {:ok, _pid} = start_supervised({Worker, []})
    end

    test "with start_supervised!" do
      assert start_supervised!({Worker, []})
    end

    test "with start_supervised! and a command arg" do
      assert start_supervised!({Worker, [command: ~s(echo HI)]})
    end

    test "without arguments" do
      assert start_supervised!(Worker)
    end

    test "registered process name" do
      start_supervised({Worker, []})
      assert Process.whereis(:runner_worker)
    end
  end

  describe "start_supervised with command args" do
    test "with echo" do
      assert start_supervised({Worker, [command: "echo BYE"]})
    end
  end

  describe "#getcmd/0" do
    test "with echo" do
      cmd = "echo HI"
      assert start_supervised({Worker, [command: cmd]})
      assert Worker.getcmd() == cmd
    end
  end

  describe "#setcmd/1" do
    test "with echo" do
      cmd = "echo HI"
      assert start_supervised({Worker, []})
      assert Worker.setcmd(cmd)
      assert Worker.getcmd() == cmd
    end
  end

  describe "#run/1" do
    test "with a simple command" do
      start_supervised(Worker)
      result = Worker.run("ls ~")
      assert result == :ok
    end

    test "without arguments" do
      start_supervised(Worker)
      result = Worker.run("ls")
      assert result == :ok
    end

    test "commands in rapid succession" do
      start_supervised(Worker)
      Enum.each(1..5, fn _ -> Worker.run("hostname") end)
    end
  end

  describe "#post/1" do
    test "with empty command" do
      start_supervised(Worker)
      assert Worker.post("qwer") == :ok
    end

    test "with empty data" do
      start_supervised({Worker, [command: "echo @data"]})
      assert Worker.post("") == :ok
    end

    test "with no data element" do
      start_supervised({Worker, [command: "echo HI"]})
      assert Worker.post("DATA") == :ok
    end

    test "with data and data element" do
      start_supervised({Worker, [command: "echo @data"]})
      assert Worker.post("HI") == :ok
    end

    test "with redirect" do
      rand = Util.File.rand()
      file = Path.join(System.tmp_dir!(), "datafile_#{rand}.txt")
      data = "HELLOWORLD"
      cmd  = "echo @data > #{file}"
      start_supervised({Worker, [command: cmd]})
      assert Worker.getcmd() == cmd
      assert Worker.post(data) == :ok
      assert File.exists?(file)
      assert File.read!(file) |> String.trim() == data
      System.cmd("rm", ["-f", file])
    end
  end

end
