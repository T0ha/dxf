defmodule Dxf.Section.Entities do
  @moduledoc """
  Entities section of a DXF file.
  Handles parsing of entity objects like LINE, CIRCLE, ARC etc.
  """

  require Dxf.Type

  @type t() :: %{
          entities: [map()]
        }

  @entity_type "0"

  @spec parse([String.t()], map()) :: map()
  def parse([@entity_type, "ENDSEC" | rest], acc) do
    Dxf.parse_tagged(rest, acc)
  end

  def parse(data, acc) do
    {entity, rest} = Dxf.Type.parse(data)
    new_acc = Map.update(acc, :entities, [entity], &[entity | &1])
    parse(rest, new_acc)
  end
end
