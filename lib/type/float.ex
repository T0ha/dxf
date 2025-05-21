defmodule Dxf.Type.Float do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Behaviour,
    tags: [
      40..48,
      50..58, # Angles
      140..149
    ]

  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()]) :: {integer(), [String.t()]}
  def parse([_type, x | rest]) do
    {String.to_float(x), rest}
  end
end
