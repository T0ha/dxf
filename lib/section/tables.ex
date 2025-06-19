defmodule Dxf.Section.Tables do
  @moduledoc """
  Tables section of a DXF file.
  Contains various symbol tables such as LAYER, LTYPE, STYLE, etc.
  """

  @type t() :: %{}

  @entity_type "0"
  @table_start "TABLE"
  @table_end "ENDTAB"
  @variable "9"

  @valid_table_types ~w(LAYER LTYPE STYLE VPORT)
  @default_table_name "UNKNOWN"

  @spec parse([String.t()], map()) :: map()
  def parse([@entity_type, "ENDSEC" | rest], acc) do
    Dxf.parse_tagged(rest, acc)
  end

  def parse([@entity_type, @table_start | rest], acc) do
    {table_name, entries, rest} = parse_table(rest, []) |> IO.inspect()

    new_acc =
      update_in(acc.tables, fn tables ->
        Map.put(tables || %{}, table_name, entries)
      end)

    parse(rest, new_acc)
  end

  #  def parse([_type, _value | rest], acc) do
  #    parse(rest, acc)
  #  end

  @spec parse_table([String.t()], [map()]) :: {String.t(), [map()], [String.t()]}
  defp parse_table([@entity_type, @table_end | rest], entries) do
    {table_name(entries), Enum.reverse(entries), rest}
  end

  defp parse_table([@entity_type, entry_type | rest], entries) do
    {entry, rest} = parse_entry(rest, %{type: entry_type})
    parse_table(rest, [entry | entries])
  end

  defp parse_table([type, value | rest], entries) do
    parse_table(rest, [Map.put(List.first(entries, %{}), String.to_atom(type), value) | entries])
  end

  defp parse_table([_type, table_name | rest], []),
    do: parse_table(rest, [%{table_name: table_name}])

  @spec parse_entry([String.t()], map()) :: {map(), [String.t()]}
  defp parse_entry([@entity_type, @table_end | _rest] = rest, entry), do: {entry, rest}
  defp parse_entry([@entity_type, _next_entry | _rest] = rest, entry), do: {entry, rest}

  defp parse_entry([type, value | rest], entry) do
    parse_entry(rest, Map.put(entry, String.to_atom(type), value))
  end

  defp table_name(entries) do
    case List.first(entries, %{}) do
      %{table_name: name} ->
        if name in @valid_table_types do
          name
        else
          @default_table_name
        end

      _ ->
        @default_table_name
    end
  end
end
