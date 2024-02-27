defmodule Formin.MixProject do
  use Mix.Project

  def project do
    [
      app: :formin,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Formin.Application, []}
    ]
  end

  defp deps do
    [
      # ----- basics
      {:jason, "~> 1.4"},
      {:bandit, "~> 1.0"},
      # ----- cli
      {:optimus, "~> 0.5"},
      # ----- testing
      {:mix_test_interactive, "~> 2.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      itest: ["test.interactive"],
    ]
  end
end
