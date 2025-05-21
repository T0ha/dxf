defmodule Dxf.Type.String do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Behaviour,
    tags: [
      [1, 
        2, # Name
        3, 4, 
        5, # Entity handle, Hex 
        6, # Line type
        7, # text style name
        8, #Layer name
        100, 102], 
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
