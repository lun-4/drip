defmodule Drip.Server do
  use GenServer

  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, _socket} = :gen_udp.open(5569, [:binary])
    Logger.info("Drip.Server: udp start")

    {:ok, nil}
  end

  def handle_info({:udp, _socket, addr, port, data}, state) do
    Logger.info("awooga #{inspect(addr)} #{inspect(port)} #{inspect(data)}")
    {:noreply, state}
  end
end
