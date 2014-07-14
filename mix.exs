defmodule Zencoder.Mixfile do
  use Mix.Project

  def project do
    [app: :zencoder,
     version: "0.0.1",
     elixir: "~> 0.14.3",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpoison],
     mod: {Zencoder, []}]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:httpoison,    "~> 0.3.0"},
      {:hackney, github: "benoitc/hackney", ref: "cf90543f9cc21ffea34d71035521b0102b8555cf"}
    ]
  end
end
