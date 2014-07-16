defmodule Zencoder.Mixfile do
  use Mix.Project

  def project do
    [
      app: :zencoder,
      version: "0.1.1",
      elixir: "~> 0.14.3",
      test_coverage: [tool: ExCoveralls],
      deps: deps(Mix.env),
      package: [
        contributors: ["Adam Kittelson"],
        licenses: ["MIT"],
        links: [github: "https://github.com/zencoder/zencoder-ex", zencoder: "https://zencoder.com"]
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
  def deps(:dev) do
    deps(:prod)
  end

  def deps(:test) do
    deps(:prod) ++
    [
      {:exvcr, "~> 0.1.7"},
      {:excoveralls, "~> 0.2.4"},
      {:meck, "0.8.2", github: "eproxus/meck"}
    ]
  end

  def deps(:prod) do
    [
      {:httpotion, "~> 0.2.4"},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.0"},
      {:jazz, "~> 0.1.2"},
    ]
  end

end
