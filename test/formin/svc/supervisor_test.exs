defmodule Formin.Svc.SupervisorTest do

  use ExUnit.Case, async: false

  alias Formin.Svc.Supervisor
  # alias Formin.Svc.Runner.Worker

  describe "#start_link/1" do
    test "with [server: true]" do
      assert {:ok, _pid} = start_supervised({Supervisor, [server: true]})
    end
  end

  describe "passing down commands" do
    test "with start_supervised! and a command arg" do
      cmd = "echo HI"
      Application.put_env(:formin, :command, cmd)
      assert start_supervised!({Supervisor, [server: true]})
      # assert Worker.getcmd() == cmd
    end
  end

end
