defmodule Dxf do
  @moduledoc """
  Documentation for `Dxf`.
  """
  alias Dxf.Section.{Classes, Entities, Header, Stub, Tables}

  @type t() :: %__MODULE__{
          header: list(),
          classes: list(),
          tables: map(),
          blocks: map(),
          entities: map(),
          objects: map()
        }

  defstruct [
    :tables,
    :classes,
    :blocks,
    :entities,
    :objects,
    header: %{}
  ]

  @entity_type "0"
  @name "2"

  @doc """
  Parses a DXF file and returns a map of sections.
  """
  def parse_file(file_path) do
    file_path
    |> File.read!()
    |> parse()
  end

  def parse(data) do
    data
    |> String.split("\r\n", trim: false)
    |> Enum.map(&String.trim/1)
    |> parse_tagged()
  end

  def parse_tagged(data), do: parse_tagged(data, %__MODULE__{})

  def parse_tagged([], acc), do: acc

  def parse_tagged([@entity_type, type, @name, name | rest], acc) do
    parse_type(type, name, rest, acc)
  end

  # defp parse_tagged([@name, name | rest], acc, nil) do
  #  parse_entity(type, name, rest, acc)
  # end

  def parse_tagged([@entity_type, "EOF" | _rest], acc) do
    acc
  end

  defp parse_type(_, type, rest, acc) do
    case type do
      "HEADER" ->
        Header.parse(rest, acc)

      # "CLASSES" -> Stub.parse(rest, acc)
      # "TABLES" -> Stub.parse(rest, acc)
      # "BLOCKS" -> Stub.parse(rest, acc)
      "ENTITIES" ->
        Entities.parse(rest, acc)

      # "OBJECTS" -> Stub.parse(rest, acc)
      section ->
        IO.inspect("Unknown section : #{section}")
        Stub.parse(rest, acc)
    end
  end
end
