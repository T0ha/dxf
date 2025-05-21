defmodule Dxf.Section.Header do
  @moduledoc """
  Header section of a DXF file.
  """
  require Dxf.Type

  @type t() :: %{}


  @entity_type "0"
  @variable "9"

  @spec parse([String.t()], map()) :: map()
  def parse([@entity_type, "ENDSEC" | rest], acc) do
    Dxf.parse_tagged(rest, acc)
  end

  def parse([@variable, name | rest], acc) do
    {value, rest} = Dxf.Type.parse(rest) |> IO.inspect(limit: 100, printable_limit: :infinity)
    new_acc = put_in(acc.header[name], value)
    parse(rest, new_acc)
  end

  @spec parse_value([String.t()], [String.t()]) :: {map(), [String.t()]}
  def parse_value([@entity_type, "ENDSEC" | _rest] = rest, acc), do: {acc, rest}
  def parse_value([@variable | _rest] = rest, acc), do: {acc, rest}
  def parse_value([type, value | rest], acc), do:
    parse_value(rest, [{type, value} | acc])
end
