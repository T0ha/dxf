defmodule Dxf.Type.Entity.HatchTest do
  use Dxf.EntityCase, async: true

  alias Dxf.Type.Entity.Hatch.BoundaryPath
  alias Dxf.Type.Entity.Hatch.BoundaryPath.BoundaryData
  alias Dxf.Type.Entity.Hatch.PatternData

  test_entity Dxf.Type.Entity.Hatch, "type =  external", ~S(0
    HATCH
    5
    910F
    330
    22
    100
    AcDbEntity
    8
    проектный
    6
    Continuous
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
    ANSI37
    70
    0
    71
    0
    91
    4
    92
    1
    93
    4
    72
    1
    10
    7013.945213514794
    20
    5311.040307810286
    11
    7008.456956838817
    21
    5308.473043986488
    72
    1
    10
    7008.456956838817
    20
    5308.473043986488
    11
    7008.139175129892
    21
    5309.152392781637
    72
    1
    10
    7008.139175129892
    20
    5309.152392781637
    11
    7005.532257362315
    21
    5307.932944408237
    72
    2
    10
    7009.60835013321
    20
    5309.839634661805
    40
    4.499999999999819
    50
    205.0689711831193
    51
    375.4749029562762
    73
    1
    97
    0
    92
    1
    93
    5
    72
    1
    10
    7007.821393420481
    20
    5309.831741577817
    11
    7007.185830002748
    21
    5311.190439166915
    72
    1
    10
    7007.185830002748
    20
    5311.190439166915
    11
    7005.125005118649
    21
    5310.226438850513
    72
    2
    10
    7009.60835013321
    20
    5309.839634661806
    40
    4.499999999999415
    50
    175.0689711831524
    51
    205.0689711831347
    73
    1
    72
    1
    10
    7005.532257362315
    20
    5307.932944408237
    11
    7008.13917512989
    21
    5309.152392781637
    72
    1
    10
    7008.13917512989
    20
    5309.152392781637
    11
    7007.821393420481
    21
    5309.831741577817
    97
    0
    92
    1
    93
    5
    72
    2
    10
    7009.608350133212
    20
    5309.839634661808
    40
    4.499999999998459
    50
    34.66303940995296
    51
    112.7696252009874
    73
    1
    72
    2
    10
    7013.422531351588
    20
    5322.614679547271
    40
    10.26013012807639
    50
    237.2145802601718
    51
    242.2847249748542
    73
    1
    72
    1
    10
    7008.650769785609
    20
    5313.53169755882
    11
    7009.267661765129
    21
    5313.820263592758
    72
    1
    10
    7009.267661765129
    20
    5313.820263592758
    11
    7010.538788601562
    21
    5311.102868412497
    72
    1
    10
    7010.538788601562
    20
    5311.102868412497
    11
    7013.309650096939
    21
    5312.399005400584
    97
    0
    92
    1
    93
    3
    72
    2
    10
    7006.251710588099
    20
    5312.658086301946
    40
    0.5125489428757635
    50
    300.0656996672721
    51
    314.2297900442338
    73
    0
    72
    1
    10
    7006.609232827071
    20
    5313.025352237588
    11
    7007.003291235466
    21
    5312.761049913862
    72
    2
    10
    7013.421711860392
    20
    5322.614304795117
    40
    11.75936882121938
    50
    123.0802634461636
    51
    126.0074346757833
    73
    0
    97
    0
    75
    1
    76
    1
    52
    0.0
    41
    5.0
    77
    0
    78
    2
    53
    45.0
    43
    -384.580644439
    44
    0.0
    45
    -0.4419417382415922
    46
    0.4419417382415923
    79
    0
    53
    135.0
    43
    -384.580644439
    44
    0.0
    45
    -0.4419417382415923
    46
    -0.4419417382415922
    79
    0
    98
    4
    10
    7008.851048336379
    20
    5307.535607443795
    10
    7006.898552901759
    20
    5309.528565144614
    10
    7010.893947977272
    20
    5312.175091183968
    10
    7006.529412956568
    20
    5312.782489273049
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
    0.0) do
    assert entity.elevation_point == %Point{x: 0.0, y: 0.0, z: 0.0}
    assert entity.extrusion_direction == %Point{x: 0.0, y: 0.0, z: 1.0}

    for boundary_path <- entity.boundary_paths do
      assert %BoundaryPath{} = boundary_path
      assert length(boundary_path.boundary_data) == 0

      for boundary_data <- boundary_path.boundary_data do
        assert %BoundaryData{
                 n_vertices: n_vertices,
                 vertices: vertices
               } = boundary_data

        assert length(vertices) == n_vertices
      end

      assert length(boundary_path.edges) == boundary_path.n_edges

      assert boundary_path.n_source_objects == length(boundary_path.source_object_refs)
    end

    assert entity.n_boundary_paths == 4
    assert length(entity.boundary_paths) == entity.n_boundary_paths

    for pattern_data <- entity.pattern_lines do
      assert %PatternData{
               n_dash_lengths: n,
               dash_lengths: dash_lengths
             } = pattern_data

      assert length(dash_lengths) == n
    end

    assert length(entity.seed_points) == entity.n_seed_points

    assert entity.pattern_name == "ANSI37"
    assert entity.solid_fill == 0
    assert entity.pattern_fill_color == 0
    assert entity.association_flag == 0
  end

  test_entity Dxf.Type.Entity.Hatch, "type = polyline", ~S(0
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
  0.0) do
    assert entity.elevation_point == %Point{x: 0.0, y: 0.0, z: 0.0}
    assert entity.extrusion_direction == %Point{x: 0.0, y: 0.0, z: 1.0}

    for boundary_path <- entity.boundary_paths do
      assert %BoundaryPath{} = boundary_path
      assert length(boundary_path.boundary_data) == 1

      for boundary_data <- boundary_path.boundary_data do
        assert %BoundaryData{
                 n_vertices: n_vertices,
                 vertices: vertices
               } = boundary_data

        assert length(vertices) == n_vertices
      end

      assert length(boundary_path.edges) == boundary_path.n_edges

      assert boundary_path.n_source_objects == length(boundary_path.source_object_refs)
    end

    assert entity.n_boundary_paths == 1
    assert length(entity.boundary_paths) == entity.n_boundary_paths

    for pattern_data <- entity.pattern_lines do
      assert %PatternData{
               n_dash_lengths: n,
               dash_lengths: dash_lengths
             } = pattern_data

      assert length(dash_lengths) == n
    end

    assert length(entity.seed_points) == entity.n_seed_points
    assert entity.pattern_name == "SOLID"
    assert entity.solid_fill == 1
    assert entity.pattern_fill_color == 5
    assert entity.association_flag == 0
    assert entity.n_boundary_paths == 1
    assert length(entity.boundary_paths) == 1
    assert entity.hatch_style == 1
    assert entity.hatch_pattern_type == 1
    assert entity.pattern_angle == 0.0
    assert entity.pixel_size == 0.0700968387308667
  end
end
