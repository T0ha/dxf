defmodule Dxf.Type.Entity.MtextTest do
  use Dxf.EntityCase

  describe "Mtext entity" do
    test_entity Dxf.Type.Entity.Mtext,
                ~S(0
      MTEXT
      5
      42F09
      330
      6961
      100
      AcDbEntity
      8
      ПЛАНИРОВКА_ТЕРРИТОРИИ_Ном._пера__7_Ном._пера__7_Ном._пера__7
      6
      Continuous
      62
      9
      100
      AcDbMText
      10
      7030.56906459879
      20
      5293.671685954908
      30
      0.0
      40
      0.75
      41
      0.0
      46
      0.0
      71
      1
      72
      1
      1
      {А}
      7
      SHRFT
      11
      0.6423652095958184
      21
      0.766398680518776
      31
      0.0
      73
      1
      44
      1.0) do
      assert entity.handle == "42F09"
      assert entity.block == "6961"
      assert entity.class == "AcDbMText"
      assert entity.layer == "ПЛАНИРОВКА_ТЕРРИТОРИИ_Ном._пера__7_Ном._пера__7_Ном._пера__7"
      assert entity.color == 9
      assert entity.linetype == "Continuous"

      assert entity.insertion_point == %Point{x: 7030.56906459879, y: 5293.671685954908, z: 0.0}
      assert entity.width == 0.0
      assert entity.height == 0.75
      assert entity.rotation_angle == 0.0
      assert entity.text_style == "SHRFT"
      assert entity.attachment_point == 1
      assert entity.text_direction == 1
      assert entity.text_spacing == 1

      assert entity.x_axis_direction == %Point{
               x: 0.6423652095958184,
               y: 0.766398680518776,
               z: 0.0
             }

      assert entity.extrusion_direction == %Point{x: 0.0, y: 0.0, z: 1.0}
      assert entity.line_spacing_factor == 1.0
    end
  end
end
