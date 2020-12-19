defmodule Drip.Protocol.GameData.Movement do
  @game_data_type 0x01

  use Codec.Generator

  make_encoder_decoder do
    <<
      # TODO packed
      player_id::32,
      sequence::16,

      # those are declared as ushort16 on docs, what?
      x_pos::16,
      y_pos::16,
      x_velocity::16,
      y_velocity::16
    >>
  end
end
