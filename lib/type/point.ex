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

  @x [
       10..19,
       210..219
     ]
     |> Stream.concat()
     |> Stream.map(&to_string/1)
     |> Enum.to_list()

  @y [
       20..29,
       220..229
     ]
     |> Stream.concat()
     |> Stream.map(&to_string/1)
     |> Enum.to_list()

  @z [
       30..39,
       230..239
     ]
     |> Stream.concat()
     |> Stream.map(&to_string/1)
     |> Enum.to_list()

  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()]) :: {t(), [String.t()]}
  def parse([x_tag, x, y_tag, y, z_tag, z | rest])
      when x_tag in @x and y_tag in @y and z_tag in @z do
    point = %__MODULE__{x: String.to_float(x), y: String.to_float(y), z: String.to_float(z)}
    {point, rest}
  end

  def parse([x_tag, x, y_tag, y | rest]) do
    point = %__MODULE__{x: String.to_float(x), y: String.to_float(y), z: nil}
    {point, rest}
  end

  def to_string_enum(data) do
    data
    |> Stream.concat()
    |> Stream.map(&to_string/1)
    |> Enum.to_list()
  end
end
