defmodule Dxf.Type.Entity.Arc do
  @moduledoc """
  A module for handling points in DXF files.
  """
  alias Dxf.Type.Point

  @behaviour Dxf.Type.Entity

  @type t() :: %__MODULE__{
    center: Poin.t(),
    radius: float(),
    thickness: float(),
    start_angle: float(),
    end_angle: float(),
    extrusion_direction: Point.t(),
  }

  defstruct [
    center: %Point{},
    radius: 0.0,
    thickness: 0.0,
    start_angle: 0.0,
    end_angle: 0.0,
    extrusion_direction: %Point{x: 0.0, y: 0.0, z: 1.0}
  ]


  @entity "0"

  @center "10"
  @radius "40"
  @thickness "39"
  @start_angle "50"
  @end_angle "51"
  @extrusion_direction "210"


  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()], %__MODULE__{}) :: {%__MODULE__{}, [String.t()]}
  def parse([@entity | _] = rest, acc), do: {acc, rest}
  def parse([@center | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | center: point})
  end
  def parse([@radius, radius | rest], acc) do
    parse(rest, %{acc | radius: String.to_float(radius)})
  end
  def parse([@extrusion_direction | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | extrusion_direction: point})
  end
  def parse([@thickness, thickness | rest], acc) do
    parse(rest, %{acc | thickness: String.to_float(thickness)})
  end
  def parse([@start_angle, start_angle | rest], acc) do
    parse(rest, %{acc | start_angle: String.to_float(start_angle)})
  end
  def parse([@end_angle, end_angle | rest], acc) do
    parse(rest, %{acc | end_angle: String.to_float(end_angle)})
  end
  def parse(rest, acc), do: {acc, rest} |> IO.inspect(label: "Line.parse")
end
