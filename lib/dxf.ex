defmodule Dxf do
  @moduledoc """
  Documentation for `Dxf`.
  """
  alias Dxf.Section.Header

  @type t() :: %__MODULE__{
          header: list(),
          tables: map(),
          blocks: map(),
          entities: map(),
          objects: map()
        }

  defstruct [
    :tables,
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
    |> String.split("\r\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> parse_tagged()
  end

  def parse_tagged(acc), do: parse_tagged(acc, %__MODULE__{})

  def parse_tagged([], acc), do: acc

  def parse_tagged([@entity_type, type, @name, name | rest], acc) do
    parse_type(type, name, rest, acc)
  end

  #defp parse_tagged([@name, name | rest], acc, nil) do
  #  parse_entity(type, name, rest, acc)
  #end

  def parse_tagged([tag, data | rest], acc) do
    {{tag, data}, rest, acc}
  end

  defp parse_type(_, type, rest, acc) do
    case type do
      "HEADER" -> Header.parse(rest, acc)
      #"TABLES" -> parse_tables(rest, acc)
      #"BLOCKS" -> parse_blocks(rest, acc)
      #"ENTITIES" -> parse_entities(rest, acc)
      #"OBJECTS" -> parse_objects(rest, acc)
      _ -> {:error, "Unknown section: #{type}"}
    end
  end
end
