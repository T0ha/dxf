defmodule Dxf.Type.Entity do
  @moduledoc """
  Represents a DXF entity.
  """

    use Dxf.Type.Behaviour,
    tags: [
      [0]
    ]

  @callback parse([String.t()]) :: {struct(), [String.t()]}

  defmacro __using__(_opts) do
    quote do
      import Dxf.Type.Entity
      alias Dxf.Type.{Float, Int, Point, String}

      @behaviour Dxf.Type.Entity

      Module.register_attribute(__MODULE__, :tags, accumulate: true)
    end
  end

  defmacro entity(type, do: do_block) do
    prelude =
      quote do
        unquote(do_block)
        def inspect do
          @tags
        end
      end

    postlude =
      quote unquote: false do
        defstruct Enum.map(@tags, fn %{key: key, default: default} -> {key, default} end)

        def parse(data), do: parse(data, %__MODULE__{})

        @impl true
        for %{
          key: key,
          tag: tag,
          module: module,
          multiple: multiple
        } <- @tags do
          if multiple do
            defp parse([unquote(tag) | _] = data, acc) do
              {entity, rest} = unquote(module).parse(data)
              parse(rest, Map.update(acc, unquote(key), [entity], fn values ->
                [entity | values] end)) |> IO.inspect(label: "Parsing #{__MODULE__}")
            end
          else 
            defp parse([unquote(tag) | _] = data, acc) do
              {entity, rest} = unquote(module).parse(data)
              parse(rest, Map.put(acc, unquote(key), entity)) |> IO.inspect()
            end
          end
        end
        defp parse(rest, acc), do: {acc, rest}
        

      end
    quote do
      unquote(prelude)
      unquote(postlude)
    end
  end

  defmacro tag(key, tag, prser_module, default \\ nil, multiple \\ false) do
    quote do
      # tags = Module.get_attribute(__MODULE__, :tags, [])

      # is_duplicated? = Enum.any?(tags,
      #   fn {key, tag, _, _} -> 
      #     key == unquote(key)
      #       or MapSet.dosjoint?(MapSet.new(unquote(tag)), MapSet.new(tags)) 
      # end)

      # if is_duplicated? do
      #   raise ArgumentError, "Duplicated key #{key} or tags #{inspect tags}"
      # end

      Module.put_attribute(__MODULE__, :tags, %{
        key: unquote(key),
        tag: unquote(tag),
        module: unquote(prser_module),
        default: unquote(default),
        multiple: unquote(multiple)
      })
    end
  end

  @type t :: %__MODULE__{
    type: String.t(),
    handle: String.t() | nil,
    class: String.t() | nil,
    block: String.t() | nil,
    layer: String.t() | nil,
    color: integer() | nil,
    linetype: String.t() | nil,
    linetype_scale: float(),
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
    linetype_scale: 1.0,
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
  @linetype_scale "48"
  @lineweight "370"

  @impl true
  def parse([@entity, type | rest]) do
    type = 
      type
      |> String.capitalize()
      |> then(&Module.concat([__MODULE__, &1]))

    parse_entity(rest,
      %__MODULE__{
      type: type
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
  defp parse_entity([@linetype_scale,linetype_scale | rest], acc) do
    parse_entity(rest, %{acc | linetype_scale: linetype_scale})
  end
  defp parse_entity([@lineweight, lineweight | rest], acc) do
    parse_entity(rest, %{acc | lineweight: String.to_integer(lineweight)})
  end
  defp parse_entity(rest, %__MODULE__{type: type} = acc) do
    {entity, rest} =  type.parse(rest)
    parse_entity(rest, %{acc | entity: entity})
  end
end
