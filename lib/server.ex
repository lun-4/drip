defmodule Drip.Server do
  use GenServer

  require Logger
  alias Drip.Protocol.Packet

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, _socket} = :gen_udp.open(22023, [:binary])
    Logger.info("Drip.Server: udp start")

    {:ok, nil}
  end

  @opcode_map %{
    Packet.Unreliable.opcode() => Packet.Unreliable,
    Packet.Reliable.opcode() => Packet.Reliable,
    Packet.Hello.opcode() => Packet.Hello,
    Packet.Disconnect.opcode() => Packet.Disconnect,
    Packet.Ping.opcode() => Packet.Ping
  }

  def handle_info({:udp, socket, addr, port, data}, state) do
    Logger.info("awooga #{inspect(addr)} #{inspect(port)} #{inspect(data)}")

    <<packet_type::8, packet_rest::binary>> = data
    IO.puts(packet_type)

    packet_atom = Map.get(@opcode_map, packet_type)
    IO.puts(packet_atom)

    if packet_atom do
      packet = packet_atom.decode(packet_rest)
      IO.inspect(packet)

      encoded =
        Packet.Disconnect.encode(
          "",
          %Packet.Disconnect.S{
            reason: Map.get(Packet.Disconnect.reasons(), :forced)
          }
        )

      :gen_udp.send(socket, addr, port, encoded)
    else
      Logger.warn("unknown packet type #{packet_type}")

      encoded =
        Packet.Disconnect.encode(
          "",
          %Packet.Disconnect.S{
            reason: Map.get(Packet.Disconnect.reasons(), :bad_connection)
          }
        )

      :gen_udp.send(socket, addr, port, encoded)
    end

    {:noreply, state}
  end
end
