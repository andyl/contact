defmodule ForminTest do
  use ExUnit.Case
  doctest Formin

  test "greets the world" do
    assert Formin.hello() == :world
  end
end
