defmodule Drip.Protocol.Command.Unreliable.GameData do
  @command_type 0x05

  use Codec.Generator

  make_encoder_decoder do
    <<
      game_session_code::32,
      game_data_length::16,
      # TODO this is unsigned?
      game_data_type::8,
      game_data::binary
    >>
  end
end
