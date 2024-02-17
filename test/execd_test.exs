defmodule ExecdTest do
  use ExUnit.Case
  doctest Execd

  test "greets the world" do
    assert Execd.hello() == :world
  end
end
