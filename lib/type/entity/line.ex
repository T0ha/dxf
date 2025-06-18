defmodule Dxf.Type.Entity.Line do
  @moduledoc """
  A module for handling points in DXF files.
  """
  use Dxf.Type.Entity
  alias Dxf.Type.{Point, Float}

  entity "LINE" do
    tag(:start_point, "10", Point, %Point{})
    tag(:end_point, "11", Point, %Point{})
    tag(:thickness, "39", Float, 0.0)
    tag(:extrusion_direction, "210", Point, %Point{})
  end
end
