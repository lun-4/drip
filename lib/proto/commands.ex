defmodule Drip.Protocol.Command.JoinGame do
  def command_type, do: 0x01

  defmodule Client do
    use Codec.Generator

    make_encoder_decoder do
      <<
        # TODO game code parse
        game_code::32,
        map_ownership::8
      >>
    end
  end

  defmodule Error do
    use Codec.Generator

    # ????
    make_encoder_decoder do
      <<
        game_code::32
      >>
    end
  end
end

defmodule Drip.Protocol.Command.GameData do
  def command_type, do: 0x05

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
