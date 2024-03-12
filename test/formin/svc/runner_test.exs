defmodule Formin.Svc.RunnerTest do

  use ExUnit.Case

  alias Formin.Svc.Runner

  describe "#myfunc/1" do
    test "description" do
      assert Runner
    end
  end

  describe "#start_link/1" do
    test "using start_link directly" do
      assert {:ok, _pid} = Runner.start_link([])
    end

    test "with start_supervised" do
      assert {:ok, _pid} = start_supervised({Runner, []})
    end

    test "with start_supervised!" do
      assert start_supervised!({Runner, []})
    end

    test "with start_supervised! and a command arg" do
      assert start_supervised!({Runner, [command: ~s(echo HI)]})
    end

    test "without arguments" do
      assert start_supervised!(Runner)
    end

    test "without bang" do
      assert start_supervised(Runner)
    end

    test "registered process name" do
      start_supervised({Runner, []})
      assert Process.whereis(:svc_runner)
    end
  end

end
