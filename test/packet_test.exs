defmodule Drip.Protocol.Packet.Test do
  use ExUnit.Case

  test do
    data = <<"\x08\x00\x01\x00\x4a\xe2\x02\x03\x0a\x62\x69\x67\x20\x63\x68\x75\x6e\x67\x69">>
    packet = Drip.Protocol.Packet.decode(data)
    IO.inspect(packet)

    assert packet.opcode == 8
    assert packet.nonce == 1
    assert packet.length == 74
  end
end
