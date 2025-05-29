defmodule Dxf.Type.Entity.Arc do
  @moduledoc """
  A module for handling points in DXF files.
  """

  use Dxf.Type.Entity

  entity "ARC" do
    tag :center, "10", Point, %Point{}
    tag :radius, "40", Float, 0.0
    tag :thickness, "39", Float, 0.0
    tag :start_angle, "50", Float, 0.0
    tag :end_angle, "51", Float, 0.0
    tag :extrusion_direction, "210", Point, %Point{z: 1.0}
  end
end
