defmodule Execd.Svc.Runner.SupervisorTest do

  use ExUnit.Case

  alias Execd.Svc.Runner.Supervisor
  alias Execd.Svc.Runner.Worker

  describe "#start_link/1" do
    test "using start_link directly" do
      assert {:ok, _pid} = Supervisor.start_link([])
    end

    test "with start_supervised" do
      assert {:ok, _pid} = start_supervised({Supervisor, []})
    end

    test "with start_supervised!" do
      assert start_supervised!({Supervisor, []})
    end

    test "with start_supervised! and a command arg" do
      assert start_supervised!({Supervisor, [command: ~s(echo HI)]})
    end

    test "without arguments" do
      assert start_supervised!(Supervisor)
    end

    test "registered process name" do
      start_supervised({Supervisor, []})
      assert Process.whereis(:runner_supervisor)
      assert Process.whereis(:runner_worker)
    end
  end

  describe "passing down commands" do
    test "registered process name" do
      cmd = "echo HI"
      start_supervised({Supervisor, [command: cmd]})
      assert cmd == Worker.getcmd()
    end
  end

end
