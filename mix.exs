defmodule Drip.MixProject do
  use Mix.Project

  def project do
    [
      app: :drip,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    apps =
      [:logger]
      ++ if Mix.env() == :dev do
        [:remix]
      else
        []
      end

    [
      mod: {Drip, []},
      # TODO move remix to dev only
      extra_applications: apps
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:codec, "~> 0.1.2"},
      {:remix, "~> 0.0.1", only: :dev}
    ]
  end
end
