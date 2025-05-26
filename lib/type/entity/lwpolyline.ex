defmodule Dxf.Type.Entity.Lwpolyline do
  @moduledoc """
  A module for handling points in DXF files.
  """
  alias Dxf.Type.Point

  @behaviour Dxf.Type.Entity

  defmodule Vertex do
    @moduledoc """
    A module for handling vertexes in DXF files.
    """

    @type t() :: %__MODULE__{
      point: Point.t(),
      starting_width: float(),
      ending_width: float(),
      bulge: float()
    }

    defstruct [
      point: %Point{},
      starting_width: 0.0,
      ending_width: 0.0,
      bulge: 0.0
    ]

    @point "10"
    @starting_width "40"
    @ending_width "41"
    @bulge "42"

    @doc """
    Parses a vertex from a list of strings.
    """
    @spec parse([String.t()], Vertex.t()) :: {Vertex.t(), [String.t()]}
    def parse([@point | _] = data, acc) do
      {point, rest} = Point.parse(data)
      parse(rest, %{acc | point: point})
    end
    def parse([@starting_width, starting_width | rest], acc) do
      parse(rest, %{acc | starting_width: String.to_float(starting_width)})
    end
    def parse([@ending_width, ending_width | rest], acc) do
      parse(rest, %{acc | ending_width: String.to_float(ending_width)})
    end
    def parse([@bulge, bulge | rest], acc) do
      parse(rest, %{acc | bulge: String.to_float(bulge)})
    end
    def parse(rest, acc), do: {acc, rest} |> IO.inspect(label: "Line.parse")
  end

  @type t() :: %__MODULE__{
    n: integer(),
    constant_width: float(),
    vertexes: [Vertex.t()],
    elevation: float(),
    thickness: float(),
    polyline_flag: integer(),
    extrusion_direction: Point.t(),
  }

  defstruct [
    n: 0,
    constant_width: 0.0,
    vertexes: [],
    elevation: 0.0,
    thickness: 0.0,
    polyline_flag: 0,
    extrusion_direction: %Point{x: 0.0, y: 0.0, z: 1.0}
  ]


  @entity "0"

  @n "90"
  @polyline_flag "70"
  @constant_width "43"
  @vertex "10"
  @elevation "38"
  @thickness "39"
  @extrusion_direction "210"


  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()], %__MODULE__{}) :: {%__MODULE__{}, [String.t()]}
  def parse([@entity | _] = rest, acc), do: {acc, rest}
  def parse([@n, n | rest], acc) do
    parse(rest, %{acc | n: String.to_integer(n)})
  end
  def parse([@vertex | _] = data, acc) do
    {vertex, rest} = Vertex.parse(data, %Vertex{})
    parse(rest, %{acc | vertexes: [vertex | acc.vertexes]})
  end
  def parse([@polyline_flag, polyline_flag | rest], acc) do
    parse(rest, %{acc | polyline_flag: String.to_integer(polyline_flag)})
  end
  def parse([@constant_width, constant_width | rest], acc) do
    parse(rest, %{acc | constant_width: String.to_float(constant_width)})
  end
  def parse([@elevation, elevation | rest], acc) do
    parse(rest, %{acc | elevation: String.to_float(elevation)})
  end
  def parse([@thickness, thickness | rest], acc) do
    parse(rest, %{acc | thickness: String.to_float(thickness)})
  end
  def parse([@extrusion_direction | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | extrusion_direction: point})
  end
  def parse(rest, acc), do: {acc, rest} |> IO.inspect(label: "Line.parse")
end
