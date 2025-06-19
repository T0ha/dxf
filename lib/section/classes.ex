defmodule Dxf.Section.Classes do
  @moduledoc """
  Classes section of a DXF file.
  Contains class definitions that define custom objects.
  """

  @type class_entry :: %{
          name: String.t(),
          cpp_class: String.t(),
          app_name: String.t(),
          proxy_flag: String.t(),
          instance_count: String.t(),
          was_proxy: String.t(),
          is_entity: String.t()
        }

  @type t() :: %{classes: [class_entry()]}

  @entity_type "0"
  @record_name "1"
  @cpp_class "2"
  @app_name "3"
  @proxy_flag "90"
  @instance_count "91"
  @was_proxy "280"
  @is_entity "281"

  @spec parse([String.t()], map()) :: map()
  def parse([@entity_type, "ENDSEC" | rest], acc) do
    Dxf.parse_tagged(rest, acc)
  end

  def parse([@entity_type, "CLASS" | rest], acc) do
    {class_entry, rest} = parse_class(rest, %{})
    new_acc = update_in(acc.classes, &[class_entry | &1])
    parse(rest, new_acc)
  end

  @spec parse_class([String.t()], map()) :: {map(), [String.t()]}
  defp parse_class([@entity_type, _next | _rest] = rest, acc), do: {acc, rest}

  defp parse_class([@record_name, value | rest], acc),
    do: parse_class(rest, Map.put(acc, :name, value))

  defp parse_class([@cpp_class, value | rest], acc),
    do: parse_class(rest, Map.put(acc, :cpp_class, value))

  defp parse_class([@app_name, value | rest], acc),
    do: parse_class(rest, Map.put(acc, :app_name, value))

  defp parse_class([@proxy_flag, value | rest], acc),
    do: parse_class(rest, Map.put(acc, :proxy_flag, value))

  defp parse_class([@instance_count, value | rest], acc),
    do: parse_class(rest, Map.put(acc, :instance_count, value))

  defp parse_class([@was_proxy, value | rest], acc),
    do: parse_class(rest, Map.put(acc, :was_proxy, value))

  defp parse_class([@is_entity, value | rest], acc),
    do: parse_class(rest, Map.put(acc, :is_entity, value))

  defp parse_class([_type, _value | rest], acc), do: parse_class(rest, acc)
end
