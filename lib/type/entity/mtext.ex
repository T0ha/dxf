defmodule Dxf.Type.Entity.Mtext do
  @moduledoc """
  A module for handling multiline text (MTEXT) entities in DXF files.
  """
  alias Dxf.Type.{Float, Int, Point, String}

  use Dxf.Type.Entity

  entity "MTEXT" do
    tag(:insertion_point, "10", Point, %Point{})
    tag(:height, "40", Float, 0.0)
    tag(:width, "41", Float, 0.0)
    tag(:attachment_point, "71", Int, 0)
    tag(:text_direction, "72", Int, 0)
    tag(:text, "1", String, "")
    tag(:additional_text, "3", String, "")
    tag(:text_style, "7", String, "")
    tag(:extrusion_direction, "210", Point, %Point{x: 0.0, y: 0.0, z: 1.0})
    tag(:x_axis_direction, "11", Point, %Point{x: 1.0, y: 0.0, z: 0.0})
    tag(:horizontal_width_of_characters, "42", Float, 0.0)
    tag(:text_sustained_height, "43", Float, 0.0)
    tag(:rotation_angle, "50", Float, 0.0)
    tag(:text_spacing, "73", Int, 0)
    tag(:line_spacing_factor, "44", Float, 1.0)
    tag(:background_fill, "90", Int, 0)
    tag(:background_fill_color, "420", Int, 0)
    tag(:annotation_height, "46", Float, 0.0)
    tag(:fill_box_scale, "45", Float, 1.0)
    tag(:background_color, "63", Int, 0)
    tag(:background_transparency, "441", Int, 0)
    tag(:column_type, "75", Int, 1)
    tag(:column_count, "76", Int, 1)
    tag(:column_flow, "78", Int, 0)
    tag(:column_autoheight, "79", Float, 0.0)
    tag(:column_width, "48", Float, 0.0)
    tag(:column_gutter, "49", Float, 0.0)
    tag(:column_heights, "50", Float, 0.0)
  end
end
