defmodule ProtocCompile.MixProject do
  use Mix.Project

  def project do
    [
      app: :protoc_compile,
      version: "0.1.0",
      elixir: "~> 1.12",
      description: "protoc compiler for Mix",
      deps: deps()
    ]
  end

  def application do
    [
      applications: []
    ]
  end

  defp deps do
    [
    ]
  end
end
