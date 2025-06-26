defmodule Dxf.Type.Entity do
  @moduledoc """
  Represents a DXF entity.
  """

  use Dxf.Type.Behaviour,
    tags: [
      [0]
    ]

  @callback parse([String.t()]) :: {struct(), [String.t()]}

  defmacro __using__(opts) do
    embedded = Keyword.get(opts, :embedded, false)

    quote do
      import Dxf.Type.Entity
      alias Dxf.Type.{Float, Int, Point, String}

      @behaviour Dxf.Type.Entity

      Module.register_attribute(__MODULE__, :tags, accumulate: true)

      unless unquote(embedded) do
        tag(:handle, "5", String, "")
        tag(:class, "100", String, "AcDbEntity")
        tag(:block, "330", String, "")
        tag(:layer, "8", String, "")
        tag(:color, "62", Int, nil)
        tag(:linetype, "6", String, nil)
        tag(:linetype_scale, "48", Float, 1.0)
        tag(:lineweight, "370", Int, nil)
        tag(:default_color, "420", Int, 256)
        tag(:space, "67", Int, 0)
      end
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
      quote unquote: false, location: :keep do
        defstruct Enum.uniq(
                    Enum.map(@tags, fn %{key: key, default: default} -> {key, default} end)
                  )

        @impl true
        def parse(data), do: parse(data, %__MODULE__{})

        for %{
              key: key,
              tag: tag,
              module: module,
              default: default,
              multiple: multiple,
              duplicated: duplicated,
              if: where
            } <- Enum.reverse(@tags) do
          case duplicated do
            _ when multiple ->
              defp parse(
                     [unquote(tag) | _] = data,
                     var!(acc)
                   )
                   when unquote(where) do
                {entity, rest} = unquote(module).parse(data)

                parse(
                  rest,
                  Map.update(var!(acc), unquote(key), [entity], fn values ->
                    [entity | values]
                  end)
                  |> IO.inspect(label: "Parsing #{__MODULE__} #{unquote(key)}")
                )
              end

            true ->
              defp parse([unquote(tag) | _] = data, var!(acc)) when unquote(where) do
                {entity, rest} = unquote(module).parse(data)

                parse(rest, Map.put(var!(acc), unquote(key), entity))
                |> IO.inspect(label: "Parsing #{unquote(key)}")
              end

            _ ->
              defp parse(
                     [unquote(tag) | _] = data,
                     %__MODULE__{unquote(key) => unquote(default |> Macro.escape())} = var!(acc)
                   )
                   when unquote(where) do
                {entity, rest} = unquote(module).parse(data)

                parse(rest, Map.put(var!(acc), unquote(key), entity))
                |> IO.inspect(label: "Parsing #{unquote(key)}")
              end
          end
        end

        # TODO: 102 tags between { and } are ignored
        defp parse(["102", <<"{", app::binary>> | rest], acc) do
          ["}" | rest] = Enum.drop_while(rest, fn tag -> tag != "}" end)
          parse(rest, acc)
        end

        # TODO: Ignore Extended data (1000+ tags) ATM
        defp parse([<<"1", _, _, _>>, _value | rest], acc), do: parse(rest, acc)
        defp parse(rest, acc), do: {acc, rest}
      end

    quote do
      unquote(prelude)
      unquote(postlude)
    end
  end

  defmacro tag(key, tag, module, default \\ nil, opts \\ []) do
    multiple = Keyword.get(opts, :multiple, false)
    if_ = Keyword.get(opts, :if, true) |> Macro.escape()

    quote do
      tags = Module.get_attribute(__MODULE__, :tags, [])

      is_duplicated_key? =
        Enum.any?(
          tags,
          fn %{key: k, tag: t} ->
            # class tag
            k == unquote(key) &&
              t != "100"
          end
        ) && unquote(if_) == true

      if is_duplicated_key? do
        raise ArgumentError, "Duplicated key #{unquote(key)}"
      end

      duplicated_tags =
        tags
        |> Enum.filter(&(&1.tag == unquote(tag)))

      Module.put_attribute(__MODULE__, :tags, %{
        key: unquote(key),
        tag: unquote(tag),
        module: unquote(module),
        default: unquote(default),
        multiple: unquote(multiple),
        duplicated: duplicated_tags,
        if: unquote(if_)
      })
    end
  end

  defmacro guard(expr) do
    quote do
      unquote(Macro.escape(expr))
    end
  end

  @entity "0"

  @impl true
  def parse([@entity, type | rest]) do
    type =
      type
      |> String.capitalize()
      |> then(&Module.concat([__MODULE__, &1]))

    type.parse(rest)
  end
end
