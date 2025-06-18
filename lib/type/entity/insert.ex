defmodule Dxf.Type.Entity.Insert do
  @moduledoc """
  A module for handling points in DXF files.
  """
  use Dxf.Type.Entity

  entity "INSERT" do
    tag(:block_name, "2", String, "")
    tag(:variable_attributes_follow, "66", Int, 0)
    tag(:insertion_point, "10", Point, %Point{})
    tag(:x_scale_factor, "41", Float, 1.0)
    tag(:y_scale_factor, "42", Float, 1.0)
    tag(:z_scale_factor, "43", Float, 1.0)
    tag(:rotation_angle, "50", Float, 0.0)
    tag(:column_count, "70", Int, 1)
    tag(:row_count, "71", Int, 1)
    tag(:column_spacing, "44", Float, 0.0)
    tag(:row_spacing, "45", Float, 0.0)
    tag(:extrusion_direction, "210", Point, %Point{z: 1.0})
  end
end
