defmodule Dxf.Type.Entity.ArcTest do
  use Dxf.EntityCase

  describe "Arc entity" do
    test_entity Dxf.Type.Entity.Arc,
                ~S(0
      ARC
      5
      5F
      330
      5A
      100
      AcDbEntity
      8
      0
      62
      0
      100
      AcDbCircle
      10
      0.0
      20
      1.064999999999999
      30
      0.0
      40
      0.185
      100
      AcDbArc
      50
      355.0
      51
      195.0) do
      assert entity.handle == "5F"
      assert entity.block == "5A"
      assert entity.class == "AcDbArc"
      assert entity.layer == "0"
      assert entity.color == 0

      assert entity.center == %Point{x: 0.0, y: 1.064999999999999, z: 0.0}
      assert entity.radius == 0.185
      assert entity.start_angle == 355.0
      assert entity.end_angle == 195.0
    end
  end
end
