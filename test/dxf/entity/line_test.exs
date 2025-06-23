defmodule Dxf.Type.Entity.LineTest do
  use Dxf.EntityCase

  describe "Line entity" do
    test_entity Dxf.Type.Entity.Line,
                ~S(0
      LINE
      5
      4E
      330
      4C
      100
      AcDbEntity
      8
      0
      62
      0
      100
      AcDbLine
      10
      0.0
      20
      -1.5
      30
      0.0
      11
      0.0
      21
      1.5
      31
      0.0) do
      assert entity.start_point == %Point{x: 0.0, y: -1.5, z: 0.0}
      assert entity.end_point == %Point{x: 0.0, y: 1.5, z: 0.0}
      assert entity.handle == "4E"
      assert entity.block == "4C"
      assert entity.class == "AcDbLine"
      assert entity.layer == "0"
      assert entity.color == 0
    end
  end
end
