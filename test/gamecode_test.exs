defmodule Drip.Protocol.GameCode.Test do
  use ExUnit.Case
  alias Drip.Protocol.GameCode

  test "it works" do
    code = GameCode.string_code_to_int("AAAAAA")
    assert code == -1_679_540_573
  end
end
