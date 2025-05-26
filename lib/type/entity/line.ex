defmodule Dxf.Type.Entity.Line do
  @moduledoc """
  A module for handling points in DXF files.
  """
  alias Dxf.Type.Point

  @behaviour Dxf.Type.Entity

  @type t() :: %__MODULE__{
    start_point: Poin.t(),
    end_point: Poin.t(),
    thickness: float(),
    extrusion_direction: Point.t(),
  }

  defstruct [
    start_point: %Point{},
    end_point: %Point{},
    thickness: 0.0,
    extrusion_direction: %Point{x: 0.0, y: 0.0, z: 1.0}
  ]


  @entity "0"

  @start_point "10"
  @end_point "11"
  @thickness "39"
  @extrusion_direction "210"


  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()], %__MODULE__{}) :: {%__MODULE__{}, [String.t()]}
  def parse([@entity | _] = rest, acc), do: {acc, rest}
  def parse([@start_point | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | start_point: point})
  end
  def parse([@end_point | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | end_point: point})
  end
  def parse([@extrusion_direction | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | extrusion_direction: point})
  end
  def parse([@thickness, thickness | rest], acc) do
    parse(rest, %{acc | thickness: String.to_float(thickness)})
  end
  def parse(rest, acc), do: {acc, rest} |> IO.inspect(label: "Line.parse")
end
