defmodule Drip do
  use Application

  def start(_type, _args) do
    Supervisor.start_link(
      [
        {Drip.Supervisor, name: {:global, Drip.Supervisor}}
      ],
      strategy: :one_for_one
    )
  end
end
