defmodule TiniestBlockchain.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tiniest_blockchain,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {TiniestBlockchain, []},
      extra_applications: [:logger, :cowboy, :ranch]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 2.0"},
      {:poison, "~> 3.1"},
      {:ex_json_schema, "~> 0.5"}
    ]
  end
end
