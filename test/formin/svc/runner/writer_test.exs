defmodule Formin.Svc.Runner.WriterTest do

  use ExUnit.Case

  alias Formin.Svc.Runner.Writer

  describe "#myfunc/1" do
    test "description" do
      assert Writer
    end
  end

  describe "#start_link/1" do
    test "using start_link directly" do
      assert {:ok, _pid} = Writer.start_link([])
    end

    test "with start_supervised" do
      assert {:ok, _pid} = start_supervised({Writer, []})
    end

    test "with start_supervised!" do
      assert start_supervised!({Writer, []})
    end

    test "with start_supervised! and a command arg" do
      assert start_supervised!({Writer, [command: ~s(echo HI)]})
    end

    test "without arguments" do
      assert start_supervised!(Writer)
    end

    test "registered process name" do
      start_supervised({Writer, []})
      assert Process.whereis(:runner_writer)
    end
  end

  describe "#output/logfile" do
    test "to file" do
      # rand = Util.File.rand()
      # file = Path.join(System.tmp_dir!(), "datafile_#{rand}.txt")
      # data = "HELLOWORLD"
      # cmd  = "echo @data > #{file}"
      # start_supervised({Worker, [command: cmd]})
      # assert Worker.getcmd() == cmd
      # assert Worker.post(data) == :ok
      # assert File.exists?(file)
      # assert File.read!(file) |> String.trim() == data
      # System.cmd("rm", ["-f", file])
    end
  end

end
