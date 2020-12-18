defmodule Drip.Server do
  use GenServer

  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, socket} = :gen_udp.open(5569, [:binary])
    Logger.info("Drip.Server: udp start")

    {:ok, nil}
  end

  def handle_info({:udp, socket, addr, port, data}, _state) do
    Logger.info("awooga #{inspect(addr)} #{inspect(port)} #{inspect(data)}")
    {:noreply, _state}
  end
end
