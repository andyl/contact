defmodule ContactTest do
  use ExUnit.Case
  doctest Contact

  test "greets the world" do
    assert Contact.hello() == :world
  end
end
