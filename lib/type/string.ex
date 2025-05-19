defmodule Dxf.Type.String do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Behaviour,
    tags: [
      [1, 3, 4, 
        100, 102], 
      300..309
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
