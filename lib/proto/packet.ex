defmodule Drip.Protocol.Packet.Unreliable do
  def opcode, do: 0x00
  use Codec.Generator

  make_encoder_decoder do
    <<
      length::16,
      command_type::8,
      payload::binary
    >>
  end
end

defmodule Drip.Protocol.Packet.Reliable do
  def opcode, do: 0x01

  use Codec.Generator

  make_encoder_decoder do
    <<
      # header
      nonce::unsigned-16,
      length::unsigned-16,
      command_type::8,
      payload::binary
    >>
  end
end

defmodule Drip.Protocol.Packet.Hello do
  def opcode, do: 0x08
  use Codec.Generator

  make_encoder_decoder do
    <<
      nonce::16,
      hazel_version::8,
      client_version::32,
      client_name::binary
    >>
  end
end

defmodule Drip.Protocol.Packet.Disconnect do
  def opcode, do: 0x09
  use Codec.Generator

  def reasons,
    do: %{
      none: 0,
      game_full: 1,
      game_started: 2,
      game_not_found: 3,
      # custom_old is legacy
      custom_old: 4,
      outdated_client: 5,
      banned_from_room: 6,
      kicked_from_room: 7,
      custom: 8,
      invalid_username: 9,
      hacking: 0x0A,
      forced: 0x10,
      bad_connection: 0x11,
      game_not_found_2: 0x12,
      server_closed: 0x13,
      server_overloaded: 0x14
    }

  make_encoder_decoder do
    <<
      reason::8
    >>
  end
end

defmodule Drip.Protocol.Packet.Ack do
  def opcode, do: 0x0A
  use Codec.Generator

  make_encoder_decoder do
    <<
      nonce::16,
      missing_packets::8
    >>
  end
end

defmodule Drip.Protocol.Packet.Ping do
  def opcode, do: 0x0C
  use Codec.Generator

  make_encoder_decoder do
    <<
      nonce::16
    >>
  end
end
