defmodule Dxf.Type.Entity.Lwpolyline do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Entity

  defmodule Vertex do
    @moduledoc """
    A module for handling vertexes in DXF files.
    """
    use Dxf.Type.Entity

    entity "VERTEX" do
      tag :point, "10", Point, %Point{}
      tag :starting_width, "40", Float, 0.0
      tag :ending_width, "41", Float, 0.0
      tag :bulge, "42", Float, 0.0
    end
  end

  entity "LWPOLYLINE" do
    tag :n, "90", Int, 0
    tag :polyline_flag, "70", Int, 0
    tag :constant_width, "43", Float, 0.0
    tag :vertexes, "10", Vertex, [], true
    tag :elevation, "38", Float, 0.0
    tag :thickness, "39", Float, 0.0
    tag :extrusion_direction, "210", Point, %Point{z: 1.0}
  end
end
