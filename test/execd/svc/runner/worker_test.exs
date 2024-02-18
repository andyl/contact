# test/execd/svc/runner/worker_test.exs
defmodule Execd.Svc.Runner.WorkerTest do

  use ExUnit.Case

  alias Execd.Svc.Runner.Worker

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

    test "without arguments" do
      assert start_supervised!(Worker)
    end

    test "registered process name" do
      start_supervised({Worker, []})
      assert Process.whereis(:runner_worker)
    end
  end

  describe "#run/2" do
    test "with a simple command" do
      start_supervised(Worker)
      result = Worker.run("ls", [])
      assert result == :ok
    end

    test "without arguments" do
      start_supervised(Worker)
      result = Worker.run("ls")
      assert result == :ok
    end

    test "commands in rapid succession" do
      start_supervised(Worker)
      Enum.each(1..2000, fn _ -> Worker.run("ls") end)
    end
  end

end
