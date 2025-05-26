defmodule Dxf.Type.Entity do
  @moduledoc """
  Represents a DXF entity.
  """

    use Dxf.Type.Behaviour,
    tags: [
      [0]
    ]

  @callback parse([String.t()], struct()) :: {struct(), [String.t()]}

  @type t :: %__MODULE__{
    type: String.t(),
    handle: String.t() | nil,
    class: String.t() | nil,
    block: String.t() | nil,
    layer: String.t() | nil,
    color: integer() | nil,
    linetype: String.t() | nil,
    lineweight: integer() | nil,
    properties: map(),
    entity: struct() | nil
  }

  defstruct [
    type: "",
    handle: nil,
    class: nil,
    block: nil,
    layer: nil,
    color: nil,
    linetype: nil,
    lineweight: nil,
    properties: %{},
    entity: nil
  ]

  @entity "0"
  @handle "5"
  @class "100"
  @block "330"
  @layer "8"
  @color "62"
  @linetype "6"
  @lineweight "370"

  @impl true
  def parse([@entity, type | rest]) do
    type = 
      type
      |> String.capitalize()
      |> then(&Module.concat([__MODULE__, &1]))

    parse_entity(rest,
      %__MODULE__{
      type: type,
      entity: struct(type)
      })
  end

  defp parse_entity([@entity | _] = rest, acc), do: {acc, rest}
  defp parse_entity([@handle, handle | rest], acc) do
     parse_entity(rest, %{acc | handle: handle})
  end
  defp parse_entity([@class, class | rest], acc) do
    parse_entity(rest, %{acc | class: class})
  end
  defp parse_entity([@block, block | rest], acc) do
    parse_entity(rest, %{acc | block: block})
  end
  defp parse_entity([@layer, layer | rest], acc) do
    parse_entity(rest, %{acc | layer: layer})
  end
  defp parse_entity([@color, color | rest], acc) do
    parse_entity(rest, %{acc | color: String.to_integer(color)})
  end 
  defp parse_entity([@linetype, linetype | rest], acc) do
    parse_entity(rest, %{acc | linetype: linetype})
  end
  defp parse_entity([@lineweight, lineweight | rest], acc) do
    parse_entity(rest, %{acc | lineweight: String.to_integer(lineweight)})
  end
  defp parse_entity(rest, %__MODULE__{type: type, entity: entity} = acc) do
    {entity, rest} =  type.parse(rest, entity)
    parse_entity(rest, %{acc | entity: entity})
  end
end
