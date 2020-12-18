defmodule Drip.Protocol.Packet do
  use Codec.Generator

  make_encoder_decoder do
    <<
      # header
      opcode::little-8,
      nonce::16,
      length::little-16,
      payload_id::little-8,
      # TODO packing goes here?
      game_data::little-32,
      message_size::little-16,
      message_type::little-8,

      # TODO packing goes here
      handler_id::little-16,
      rpc_id::little-8,
      payload::binary
    >>
  end
end
