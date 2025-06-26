defmodule Dxf.Type.Entity.Mtext do
  @moduledoc """
  A module for handling multiline text (MTEXT) entities in DXF files.
  """
  alias Dxf.Type.{Float, Int, Point, String}

  use Dxf.Type.Entity

  entity "MTEXT" do
    tag(:text, "1", String, "")
    tag(:insertion_point, "10", Point, %Point{})
    tag(:width, "41", Float, 0.0)
    tag(:height, "40", Float, 0.0)
    tag(:rotation_angle, "50", Float, 0.0)
    tag(:text_style, "7", String, "")
    # FIXME: Not mentiond in spec. This tag is often used for the text height
    tag(:annotation_height, "46", Float, 0.0)
    tag(:attachment_point, "71", Int, 0)
    tag(:text_direction, "72", Int, 0)
    tag(:text_spacing, "73", Int, 0)
    tag(:thickness, "39", Float, 0.0)
    tag(:extrusion_direction, "210", Point, %Point{x: 0.0, y: 0.0, z: 1.0})
    tag(:x_axis_direction, "11", Point, %Point{x: 1.0, y: 0.0, z: 0.0})
    tag(:line_spacing_factor, "44", Float, 1.0)
  end
end
