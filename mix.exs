defmodule Nees.MixProject do
  use Mix.Project

  def project do
    [
      app: :nees,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: ["lib", "sample"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Nees.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:circuits_uart, "~> 1.5"},
      {:dialyxir, "~> 1.0.0", only: [:dev], runtime: false}
    ]
  end
end
