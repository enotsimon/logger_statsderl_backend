defmodule LoggerStatsderlBackend.Mixfile do
  use Mix.Project

  @version File.read!("VERSION") |> String.strip

  def project do
    [app: :logger_statsderl_backend,
     version: @version,
     elixir: "~> 1.0",
     description: "backend for Logger that sends counters to graphite using statsderl",
     deps: deps,
     package: package]
  end


  def application do
    [applications: [:statsderl]]
  end


  defp deps do
    [
      {:statsderl, git: "https://github.com/lpgauth/statsderl.git", tag: "0.4.3"}
    ]
  end


  defp package do
    [
      files: ~w(lib mix.exs README.md VERSION),
      maintainers: ["enotsimon"],
      licenses: ["Unlicense"],
      links: %{"GitHub" => "https://github.com/enotsimon/logger_statsderl_backend"}
    ]
  end
end
