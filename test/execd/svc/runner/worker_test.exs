# test/execd/svc/runner/worker_test.exs
defmodule Execd.Svc.Runner.WorkerTest do

  use ExUnit.Case

  alias Execd.Svc.Runner.Worker

  describe "#myfunc/1" do
    test "description" do
      assert true
    end
  end

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

    test "registered process name" do
      start_supervised({Worker, []})
      assert Process.whereis(:runner_worker)
    end
  end

#   describe "#insert/1" do
#     test "using a file with one section" do
#       start_supervised({Worker, [base_dir: base_dir()]})
#       count1 = Worker.select_all() |> length()
#       Worker.insert(Test.org_file())
#       count2 = Worker.select_all() |> length()
#       assert count2 == count1 + 1
#     end
#
#     test "using a file with three sections" do
#       start_supervised({Worker, [base_dir: base_dir()]})
#       count1 = Worker.select_all() |> length()
#       Worker.insert(Test.test_file())
#       count2 = Worker.select_all() |> length()
#       assert count2 == count1 + 3
#     end
#   end

end
