defmodule Dxf.Type.String do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Behaviour,
    tags: [
      [
        1,
        # Name
        2,
        3,
        4,
        # Entity handle, Hex 
        5,
        # Line type
        6,
        # text style name
        7,
        # Layer name
        8,
        100,
        102
      ],
      300..309,
      340..349
    ]

  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()]) :: {integer(), [String.t()]}
  def parse([type, x | rest]) do
    {x, rest}
  end
end
