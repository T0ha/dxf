defmodule Dxf.Type.Entity.HatchTest do
  use ExUnit.Case, async: true
  alias Dxf.Type.Point
  alias Dxf.Type.Entity
  alias Dxf.Type.Entity.Hatch
  alias Dxf.Type.Entity.Hatch.BoundaryPath
  alias Dxf.Type.Entity.Hatch.BoundaryPath.BoundaryData
  alias Dxf.Type.Entity.Hatch.BoundaryPath.PatternData

  @hatch_data ~S(0
  HATCH
  5
  3FAAD
  330
  3ED8C
  100
  AcDbEntity
  67
   1
  8
  ЭН-Наружное электроосвещение
  6
  Continuous
  62
  18
  420
      0
  370
   0
  100
  AcDbHatch
  10
  0.0
  20
  0.0
  30
  0.0
  210
  0.0
  220
  0.0
  230
  1.0
  2
  SOLID
  70
   1
  71
   0
  91
      1
  92
      7
  72
   0
  73
   1
  93
      3
  10
  48.67562107583319
  20
  222.3682052683916
  10
  32.67562107584775
  20
  222.3682052683971
  10
  40.67562107585138
  20
  214.3682052684016
  97
      0
  75
   1
  76
   1
  47
  0.0700968387308667
  98
      1
  10
  41.51037403437761
  20
  219.0290497140576
  450
      0
  451
      0
  460
  0.0
  461
  0.0
  452
      0
  462
  0.0
  453
      2
  463
  0.0
  63
   5
  421
    255
  463
  1.0
  63
   2
  421
  16776960
  470
  LINEAR
  1001
  GradientColor1ACI
  1070
   5
  1001
  GradientColor2ACI
  1070
   2
  1001
  ACAD
  1010
  0.0
  1020
  0.0
  1030
  0.0)

  describe "Hatch entity" do
    test "parses hatch entity data correctly" do
      {hatch, _} =
        @hatch_data
        |> String.split("\n", trim: false)
        |> Enum.map(&String.trim/1)
        |> Entity.parse()

      assert hatch.elevation_point == %Point{x: 0.0, y: 0.0, z: 0.0}
      assert hatch.extrusion_direction == %Point{x: 0.0, y: 0.0, z: 1.0}
      assert hatch.pattern_name == "SOLID"
      assert hatch.solid_fill == 1
      assert hatch.pattern_fill_color == 5
      assert hatch.association_flag == 0
      assert hatch.n_boundary_paths == 1
      assert length(hatch.boundary_paths) == 1
      assert hatch.hatch_style == 1
      assert hatch.hatch_pattern_type == 1
      assert hatch.pattern_angle == 0.0
      assert hatch.pattern_scale == 0.0700968387308667
    end

    test "default values for Hatch entity tags" do
      hatch = %Hatch{}
      assert hatch.elevation_point == %Point{}
      assert hatch.extrusion_direction == %Point{z: 1.0}
      assert hatch.pattern_name == ""
      assert hatch.solid_fill == 0
      assert hatch.pattern_fill_color == 0
      assert hatch.association_flag == 0
      assert hatch.n_boundary_paths == 0
      assert hatch.hatch_style == 0
      assert hatch.hatch_pattern_type == 0
      assert hatch.pattern_angle == 0.0
      assert hatch.pattern_scale == 1.0
    end
  end

  describe "BoundaryPath entity" do
    test "default values for BoundaryPath entity tags" do
      boundary_path = %BoundaryPath{}
      assert boundary_path.type == 0
      assert boundary_path.n_edges == 0
      assert boundary_path.n_source_objects == 0
    end
  end
end
