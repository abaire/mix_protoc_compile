defmodule Mix.Tasks.Compile.ProtocCompile do
  use Mix.Task

  @moduledoc """
    Runs `protoc` over `.proto` files in the project.
  """

  @return if Version.match?(System.version(), "~> 1.9"), do: {:ok, []},
                                                         else: :ok

  def run(args) do
    verbose? = "--verbose" in args

    config = Mix.Project.config()
    protoc_options = Keyword.get(config, :protoc_options, [])

    protoc = find_protoc(config, protoc_options)
    proto_files = find_proto_files(config, protoc_options, args)
    proto_paths = Keyword.get(protoc_options, :paths, [])

    build_protos(protoc, proto_files, proto_paths, verbose?)
  end

  defp build_protos(_, [], _, _) do
    @return
  end

  defp build_protos(protoc, proto_files, proto_paths, verbose?) do
    File.mkdir_p!("lib")

    path_args = for p <- proto_paths, do: "-I#{p}"
    args = ["--elixir_out=plugins=grpc:./lib"] ++ proto_files ++ path_args

    if verbose? do
      Mix.shell().info("Invoking #{protoc} with args #{inspect(args)}")
    end

    0 = shell_exec(protoc, args)

    @return
  end

  defp find_protoc(_, _) do
    System.find_executable("protoc") ||
      Mix.raise(
        "'protoc' not found in the PATH, please ensure that it is installed."
      )
  end

  defp find_proto_files(_, protoc_options, _) do
    Keyword.get(protoc_options, :files, [])
  end

  defp shell_exec(binary, args) do
    opts = [
      into: IO.stream(:stdio, :line),
      stderr_to_stdout: true,
    ]

    {%IO.Stream{}, exit_code} = System.cmd(binary, args, opts)

    exit_code
  end
end
