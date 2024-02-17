defmodule ContactdTest do
  use ExUnit.Case
  doctest Contactd

  test "greets the world" do
    assert Contactd.hello() == :world
  end
end
