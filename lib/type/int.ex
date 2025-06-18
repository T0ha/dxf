defmodule Dxf.Type.Int do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Behaviour,
    tags: [
      [
        # color
        62
      ],
      70..78,
      90..99,
      160..169,
      170..179,
      270..289,
      770..289
    ]

  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()]) :: {integer(), [String.t()]}
  def parse([type, x | rest]) do
    {String.to_integer(x), rest}
  end
end
