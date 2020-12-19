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

  defp packet_atom_from_packet(packet) do
    case packet do
      %Packet.Unreliable.S{} -> Packet.Unreliable
      %Packet.Reliable.S{} -> Packet.Reliable
      %Packet.Hello.S{} -> Packet.Hello
      %Packet.Disconnect.S{} -> Packet.Disconnect
      %Packet.Ack.S{} -> Packet.Ack
    end
  end

  @doc """
  Send a packet to a given UDP socket
  """
  def send_packet(socket, addr, port, packet) do
    # extract the wanted packet atom from the relevant struct, so we can
    # get the opcode
    packet_atom = packet_atom_from_packet(packet)
    packet_opcode = packet_atom.opcode()

    encoded =
      packet_atom.encode(
        "",
        packet
      )

    # prepend opcode
    result = <<packet_opcode>> <> encoded
    :gen_udp.send(socket, addr, port, result)
  end

  def handle_info({:udp, socket, addr, port, data}, state) do
    Logger.info("awooga #{inspect(addr)} #{inspect(port)} #{inspect(data)}")

    <<packet_type::8, packet_rest::binary>> = data
    IO.puts(packet_type)

    packet_atom = Map.get(@opcode_map, packet_type)
    IO.puts(packet_atom)

    if packet_atom do
      packet = packet_atom.decode(packet_rest)
      IO.inspect(packet)

      ack = %Packet.Ack.S{
        nonce: packet.nonce,
        missing_packets: 255
      }

      send_packet(socket, addr, port, ack)
    else
      Logger.warn("unknown packet type #{packet_type}")

      packet = %Packet.Disconnect.S{
        reason: Map.get(Packet.Disconnect.reasons(), :bad_connection)
      }

      send_packet(socket, addr, port, packet)
    end

    {:noreply, state}
  end
end
