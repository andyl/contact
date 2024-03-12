defmodule Formin.Svc.OptsTest do

  use ExUnit.Case

  alias Formin.Svc.Opts

  describe "#myfunc/1" do
    test "description" do
      assert Opts
    end
  end

  describe "#start_link/1" do
    test "using start_link directly" do
      assert {:ok, _pid} = Opts.start_link([])
    end

    test "with start_supervised" do
      assert {:ok, _pid} = start_supervised({Opts, []})
    end

    test "with start_supervised!" do
      assert start_supervised!({Opts, []})
    end

    test "with start_supervised! and a command arg" do
      assert start_supervised!({Opts, [command: ~s(echo HI)]})
    end

    test "without arguments" do
      assert start_supervised!(Opts)
    end

    test "without bang" do
      assert start_supervised(Opts)
    end

    test "registered process name" do
      start_supervised({Opts, []})
      assert Process.whereis(:formin_opts)
    end
  end

end
