defmodule Dxf.Type.Entity.Text do
  @moduledoc """
  A module for handling points in DXF files.
  """
  alias Dxf.Type.{Float, Int, Point, String}

  use Dxf.Type.Entity

  entity "TEXT" do
    tag(:text, "1", String, "")
    tag(:alignmnt_point, "10", Point, %Point{})
    tag(:height, "40", Float, 0.0)
    tag(:rotation_angle, "50", Float, 0.0)
    tag(:relative_scale_factor, "41", Float, 0.0)
    tag(:text_style, "7", String, "")
    tag(:second_alignmnt_point, "11", Point, %Point{})
    tag(:text_generation_flag, "71", Int, 0)
    tag(:horizontal_text_justification, "72", Int, 0)
    tag(:vertical_text_justification, "73", Int, 0)
    tag(:thickness, "39", Float, 0.0)
  end
end
