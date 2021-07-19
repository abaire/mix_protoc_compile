# ProtocCompile

Mix compiler task that invokes `protoc`

## Usage

Add `protoc_compile` o your list of dependencies in `mix.exs`:
```elixir
def deps do
  [
    {:protoc_compile, path:"path_to_this_directory"}
  ]
end
```

You also need to add `:protoc_compile` to the list of compilers in your 
`project/0` method:

```elixir
def project do
  [
    ...
    compilers: [:protoc_compile] ++ Mix.compilers,
    ...
  ]
end
```

Unless you modify the `output_path` to `lib`, you will also need to add a path 
to modify `:elixirc_paths` in your `project/0` method to include the output 
path (`gen/proto` by default).

```elixir
def project do
  [
    ...
    elixirc_paths: ["gen/proto", "lib", ...],
    ...
  ]
end
```

## Options

Options for the `protoc_compile` task should be added to the `project/0` method
via the `:protoc_options` key with an associated keyword list containing 
options.

```elixir
def project do
  [
    ...
    compilers: [:protoc_compile] ++ Mix.compilers,
    protoc_options: [files: ["test.proto", "another.proto"]],
    ...
  ]
end
```

### files []

Provides a list of one or more `.proto` files to be compiled.

### paths []

Provides a list of one or more paths to add via `--proto_path` arguments.

### output_path ""

Sets the output path for generated `.pb.ex` files (the directory will be created
if it does not exist).

*Default*: `gen/proto`
