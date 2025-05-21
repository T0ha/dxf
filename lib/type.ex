defmodule Dxf.Type do
  @moduledoc """
  A module for handling DXF types.
  """

  defmodule Behaviour do
    @callback parse([String.t()]) :: {any(), [String.t()]}



    defmacro __using__(tags: tags) do
      tags =
        tags
        |> Code.eval_quoted()
        |> elem(0)
        |> Stream.concat()
        |> Stream.map(&to_string/1)
        |> Enum.to_list()

      quote bind_quoted: [tags: tags] do
        @behaviour Dxf.Type.Behaviour

        @tags tags

        defguard is_parsable?(data) when hd(data) in @tags 

        defoverridable is_parsable?: 1
      end
    end
  end

  @modules [
    Dxf.Type.Point,
    Dxf.Type.String,
    Dxf.Type.Float,
    Dxf.Type.Int,
  ]

  # FIXME: this should generate list above automatically but it doesn't work
  #  Module.get_attribute(Types, :types)
  #  |> Enum.map(&(elem(&1, 0)))
  #  |> Enum.filter(&(String.contains?("#{&1}", "Dxf")))
  #  |> Enum.map(&String.to_atom("#{&1}"))
  #  |> IO.inspect()
  #  |> Enum.filter(fn m ->
  #    m.__info__(:attributes)[:behaviour] == [__MODULE__]
  #  end)

  @doc """
  Parses a DXF type from a list of strings.
  """
  @spec parse([String.t()]) :: {any(), [String.t()]}
  defmacro parse(data) do
    implementations = 
      @modules
      |> Enum.map(fn m ->

        [c] =
        quote do
          _tag when unquote(m).is_parsable?(unquote(data)) ->
              unquote(m).parse(unquote(data))
        end
        c
      end)

    quote location: :keep do
      require Dxf.Type.Int
      require Dxf.Type.String
      require Dxf.Type.Float
      require Dxf.Type.Point

      case hd(unquote(data)), do:
        unquote(implementations)
    end |> IO.inspect(limit: :infinity, printable_limit: :infinity)
  end
end
