defmodule DripTest do
  use ExUnit.Case
  doctest Drip

  test "greets the world" do
    assert Drip.hello() == :world
  end
end
