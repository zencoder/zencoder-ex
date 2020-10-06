defmodule Zencoder.Mixfile do
  use Mix.Project

  def project do
    [
      app: :zencoder,
      version: "1.2.0",
      elixir: "~> 1.0",
      test_coverage: [tool: ExCoveralls],
      deps: deps(),
      package: [
        contributors: ["Adam Kittelson", "Chris Warren", "Paul Nicholon"],
        licenses: ["MIT"],
        links: %{ github: "https://github.com/zencoder/zencoder-ex", zencoder: "https://zencoder.com" },
        files: ["lib/*", "mix.exs", "README.md", "LICENSE"]
      ],
      description: "Elixir API wrapper for the Zencoder video transcoding API."
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpotion],
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
  def deps do
    [
      {:httpotion, "~> 3.1.3"},
      {:jason, "~> 1.2"},
      {:exvcr, "~> 0.11.2",       only: [:dev, :test]},
      {:excoveralls, "~> 0.13.2", only: [:dev, :test]},
      {:meck, "~> 0.9.0",        only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

end
