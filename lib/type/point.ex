defmodule Dxf.Type.Point do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Behaviour,
    tags: [
      [10],
      11..18
    ]

  @type t() :: %__MODULE__{
          x: float(),
          y: float(),
          z: float()
        }

  defstruct [:x, :y, :z]


  @x "10"
  @y "20"
  @z "30"

  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()]) :: {t(), [String.t()]}
  def parse([@x, x, @y, y, @z, z | rest]) do
    point = %__MODULE__{x: String.to_float(x), y: String.to_float(y), z: String.to_float(z)}
    {point, rest}
  end
end
