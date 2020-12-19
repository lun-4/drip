defmodule Drip.Protocol.Packet.Unreliable do
  @opcode 0x00
  use Codec.Generator

  make_encoder_decoder do
    <<
      length::16,
      command_type::8,
      command_data::binary
    >>
  end
end

defmodule Drip.Protocol.Packet.Reliable do
  @opcode 0x01

  use Codec.Generator

  make_encoder_decoder do
    <<
      # header
      nonce::16,
      length::16,
      command_type::8,
      command_data::binary
    >>
  end
end

defmodule Drip.Protocol.Packet.Hello do
  @opcode 0x08
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
  @opcode 0x09
  use Codec.Generator

  @disconnect_reasons %{
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
    invalid_usernae: 9,
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
  @opcode 0x0A
  use Codec.Generator

  make_encoder_decoder do
    <<
      nonce::16,
      missing_packets::8
    >>
  end
end

defmodule Drip.Protocol.Packet.Ping do
  @opcode 0x0C
  use Codec.Generator

  make_encoder_decoder do
    <<
      nonce::16
    >>
  end
end
