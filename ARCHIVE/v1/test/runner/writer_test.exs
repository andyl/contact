defmodule Formin.Svc.Runner.WriterTest do

  use ExUnit.Case

  alias Formin.Svc.Runner.Writer
  alias Formin.Util

  import ExUnit.CaptureIO

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

    test "without bang" do
      assert start_supervised(Writer)
    end

    test "registered process name" do
      start_supervised({Writer, []})
      assert Process.whereis(:runner_writer)
    end
  end

  describe "#output/logger" do
    test "run" do
      start_supervised!(Writer)
      assert Writer.output(:logger, ".", "asdf") == :ok
    end
  end

  describe "#output/stdout" do
    test "run" do
      assert with_io(fn ->
        pid = start_supervised!(Writer)
        GenServer.cast(pid, {:rw_stdout, ".", "asdf"})
        GenServer.call(pid, :rw_flush)
      end) == {:ok, "asdf\n"}
    end
  end

  describe "#output/file" do
    test "to file" do
      rand = Util.File.rand()
      file = Path.join(System.tmp_dir!(), "testfile_#{rand}.txt")
      data = "HELLOWORLD"
      start_supervised(Writer)
      result = Writer.output(:file, file, data)
      Writer.flush()
      assert result == :ok
      assert File.exists?(file)
      assert File.read!(file) |> String.trim() == data
      System.cmd("rm", ["-f", file])
    end
  end

end
