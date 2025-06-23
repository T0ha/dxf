defmodule Dxf.Type.Entity.PointTest do
  use Dxf.EntityCase, async: true
  alias Dxf.Type.Point

  describe "Point entity" do
    test_entity Dxf.Type.Entity.Point,
                ~S(0
      POINT
      5
      4181B
      330
      6961
      100
      AcDbEntity
      8
      PI_STDEFAULT
      62
      9
      100
      AcDbPoint
      10
      7001.19
      20
      5236.689999999999
      30
      153.513) do
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
