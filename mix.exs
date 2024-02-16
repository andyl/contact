defmodule Contact.MixProject do
  use Mix.Project

  def project do
    [
      app: :contactd,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Contact.Application, []}
    ]
  end

  defp deps do
    [
      # ----- basics
      {:swoosh, "~> 1.15"},
      {:jason, "~> 1.4"},
      {:bandit, "~> 1.0"},
      # ----- testing
      {:mix_test_interactive, "~> 2.0", only: :dev, runtime: false}
    ]
  end
end
