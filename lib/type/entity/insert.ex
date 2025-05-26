defmodule Dxf.Type.Entity.Insert do
  @moduledoc """
  A module for handling points in DXF files.
  """
  alias Dxf.Type.Point

  @behaviour Dxf.Type.Entity

  @type t() :: %__MODULE__{
    block_name: String.t(),
    variable_attributes_follow: integer(),
    insertion_point: Poin.t(),
    x_scale_factor: float(),
    y_scale_factor: float(),
    z_scale_factor: float(),
    rotation_angle: float(),
    column_count: integer(),
    row_count: integer(),
    column_spacing: float(),
    row_spacing: float(),
    extrusion_direction: Point.t(),
  }

  defstruct [
    :block_name,
    :variable_attributes_follow,
    :insertion_point,
    :x_scale_factor,
    :y_scale_factor,
    :z_scale_factor,
    :rotation_angle,
    :column_count,
    :row_count,
    :column_spacing,
    :row_spacing,
    :extrusion_direction
  ]


  @entity "0"

  @block_name "2"
  @variable_attributes_follow "66"
  @insertion_point "10"
  @x_scale_factor "41"
  @y_scale_factor "42"
  @z_scale_factor "43"
  @rotation_angle "50"
  @column_count "70"
  @row_count "71"
  @column_spacing "44"
  @row_spacing "45"
  @extrusion_direction "210"


  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()], %__MODULE__{}) :: {%__MODULE__{}, [String.t()]}
  def parse([@entity | _] = rest, acc), do: {acc, rest}
  def parse([@block_name, block_name | rest], acc) do
    parse(rest, %{acc | block_name: block_name})
  end
  def parse([@insertion_point | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | insertion_point: point})
  end
  def parse([@extrusion_direction | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | extrusion_direction: point})
  end
  def parse([@rotation_angle, angle | rest], acc) do
    parse(rest, %{acc | rotation_angle: String.to_float(angle)})
  end
  def parse([@relative_scale_factor, factor | rest], acc) do
    parse(rest, %{acc | relative_scale_factor: String.to_float(factor)})
  end
  def parse([@insert_style, style | rest], acc) do
    parse(rest, %{acc | insert_style: style})
  end
  def parse([@height, height | rest], acc) do
    parse(rest, %{acc | height: String.to_float(height)})
  end
  def parse(rest, acc), do: {acc, rest}
end
