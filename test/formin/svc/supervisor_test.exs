defmodule Formin.Svc.SupervisorTest do

  use ExUnit.Case, async: false

  alias Formin.Svc.Supervisor
  alias Formin.Svc.Runner.Worker

  describe "#start_link/1" do
    # test "with []" do
    #   assert {:ok, :undefined} = start_supervised({Supervisor, []})
    # end

    test "with [server: true]" do
      assert {:ok, _pid} = start_supervised({Supervisor, [server: true]})
    end

    test "registered process name" do
      start_supervised({Supervisor, []})
      Process.sleep(100)
      # assert Process.whereis(:svc_supervisor)
      assert Process.whereis(:runner_worker)
      # assert Process.whereis(:runner_writer)
    end
  end

  describe "passing down commands" do
    test "with start_supervised! and a command arg" do
      cmd = "echo HI"
      Application.put_env(:formin, :command, cmd)
      assert start_supervised!({Supervisor, [server: true]})
      assert Worker.getcmd() == cmd
    end
  end

end
