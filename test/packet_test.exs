defmodule Drip.Protocol.Packet.Test do
  use ExUnit.Case

  alias Drip.Protocol.Packet
  alias Drip.Protocol.Command

  test "hello packet" do
    # extracted from wireshark'ing actual game
    # first byte (\x08) removed as we already know its a hello
    data = <<"\x00\x01\x00\x4a\xe2\x02\x03\x0a\x62\x69\x67\x20\x63\x68\x75\x6e\x67\x69">>
    packet = Packet.Hello.decode(data)

    assert packet.nonce == 1
    assert packet.hazel_version == 0
    assert packet.client_version == 1_256_325_635
    assert packet.client_name == "\nbig chungi"
  end

  test "join packet" do
    data = <<0, 2, 5, 0, 1, 59, 190, 37, 140, 7>>
    packet = Packet.Reliable.decode(data)
    assert packet.nonce == 2
    assert packet.command_type == Command.JoinGame.command_type()
  end
end
