defmodule Drip.Supervisor do
  use Supervisor
  require Logger

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children =
      [
        Drip.Server
      ]
      # Every children in the root supervisor should be easily
      # debuggable in IEx, so we attach them a global name, which is
      # the module atom.
      |> Enum.map(fn atom ->
        if is_atom(atom) do
          {atom, name: {:global, atom}}
        else
          atom
        end
      end)

    Logger.debug(inspect(children))
    Supervisor.init(children, strategy: :one_for_one)
  end
end
