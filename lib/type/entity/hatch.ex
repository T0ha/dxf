defmodule Dxf.Type.Entity.Hatch do
  @moduledoc """
  A module for handling hatch patterns in DXF files.
  """
  use Dxf.Type.Entity

  defmodule BoundaryPath do
    @moduledoc """
    A module for handling boundary paths in DXF hatch patterns.
    """

    use Dxf.Type.Entity

    @line 2

    defmodule BoundaryData do
      use Dxf.Type.Entity

      entity "BoundaryData" do
        tag(:has_bulge, "72", Int, 0)
        tag(:is_closed, "73", Int, 0)
        tag(:n_vertices, "93", Int, 0)
        tag(:vertices, "10", Point, [], multiple: true)
        tag(:bulge, "42", Float, 0.0)
      end
    end

    entity "BOUNDARYPATH" do
      tag(:type, "92", Int, 0)
      tag(:boundary_data, "72", BoundaryData, [], multiple: true, if: acc.type == @line)
      tag(:n_edges, "93", Int, 0)
      # FIXME: Duplicated code
      tag(:edge_type, "72", Int, 0)
      tag(:n_source_objects, "97", Int, 0)
      tag(:source_object_refs, "330", String, [], multiple: true)
    end

    defmodule PatternData do
      use Dxf.Type.Entity

      entity "PatternData" do
        tag(:line_angle, "53", Float, 0.0)
        tag(:line_base_point_x, "43", Float, 0.0)
        tag(:line_base_point_y, "44", Float, 0.0)
        tag(:line_offset_x, "45", Float, 0.0)
        tag(:line_offset_y, "46", Float, 0.0)
        tag(:n_dash_lengths, "79", Int, 0)
        tag(:dash_lengths, "49", Float, [], multiple: true)
      end
    end
  end

  entity "HATCH" do
    tag(:elevation_point, "10", Point, %Point{})
    tag(:extrusion_direction, "210", Point, %Point{z: 1.0})
    tag(:pattern_name, "2", String, "")
    tag(:solid_fill, "70", Int, 0)
    tag(:pattern_fill_color, "63", Int, 0)
    tag(:association_flag, "71", Int, 0)
    tag(:n_boundary_paths, "91", Int, 0)
    tag(:boundary_paths, "92", BoundaryPath, [], multiple: true)
    tag(:hatch_style, "75", Int, 0)
    tag(:hatch_pattern_type, "76", Int, 0)
    tag(:pattern_angle, "52", Float, 0.0)
    tag(:pattern_scale, "41", Float, 1.0)
    tag(:boundary_annotation_flag, "73", Int, 0)
    tag(:pattern_double, "77", Int, 0)
    tag(:n_pattern_definitions, "78", Int, 0)
    tag(:pattern_lines, "53", PatternData, [], multiple: true)
    tag(:pixel_size, "47", Float, 0.0)
    tag(:n_seed_points, "98", Int, 0)
    tag(:offset_vector, "11", Point, %Point{})
    tag(:n_degenerate_boundary_paths, "99", Int, 0)
    tag(:seed_points, "10", Point, [], multiple: true)
    tag(:solid_hatch_or_gradient, "450", Int, 0)
    tag(:zero, "451", Int, 0)
    tag(:dialog_code, "452", Int, 0)
    tag(:n_colors, "453", Int, 0)
    tag(:rotation_angle, "460", Float, 0.0)
    tag(:gradient_definition, "461", Float, 0.0)
    tag(:color_tint, "462", Float, 0.0)
    tag(:reserved, "463", Float, 0.0)
    tag(:string, "470", String, "LINEAR")
  end
end
