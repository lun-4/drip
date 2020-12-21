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

defmodule Drip.Protocol.Command.HostGame do
  def command_type, do: 0x00

  defmodule GameOptionsData do
    use Codec.Generator

    make_encoder_decoder do
      <<
        # TODO packed
        length::32,
        version::8,
        max_players::8,
        language::32,
        map_id::8,
        # TODO float
        speed_modifier::32,
        # TODO float
        crew_light_modifier::32,
        # TODO float
        impostor_light_modifier::32,
        # TODO float
        kill_cooldown::32,
        common_tasks::8,
        long_tasks::8,
        short_tasks::8,
        emergencies::32,
        impostor_count::8,
        kill_distance::8,
        discussion_time::32,
        voting_time::32,
        # TODO is boolean
        is_default::8,
        emergency_cooldown::8,
        confirm_ejects::8,
        visual_tasks::8,
        anonymous_voting::8,
        task_bar_updates::8
      >>
    end
  end

  defmodule Reply do
    use Codec.Generator

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
