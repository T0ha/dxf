defmodule Dxf.Section.Stub do
  @moduledoc """
  A stub for the DXF section.
  """

  @entity_type "0"

  @spec parse([String.t()], map()) :: map()
  def parse([@entity_type, "ENDSEC" | rest], acc) do
    Dxf.parse_tagged(rest, acc)
  end

  def parse([_tag, _name | rest], acc) do
    parse(rest, acc)
  end
end
