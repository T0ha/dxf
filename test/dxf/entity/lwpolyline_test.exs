defmodule Dxf.Type.Entity.LineTest do
  use Dxf.EntityCase

  describe "Line entity" do
    test_entity Dxf.Type.Entity.Lwpolyline,
                ~S(0
      LWPOLYLINE
      5
      2352
      330
      234F
      100
      AcDbEntity
      8
      0
      62
      10
      100
      AcDbPolyline
      90
      5
      70
      0
      43
      0.0
      38
      -1.5
      10
      -1.5
      20
      -1.5
      10
      -1.5
      20
      1.5
      10
      1.5
      20
      1.5
      10
      1.5
      20
      -1.5
      10
      -1.5
      20
      -1.5) do
      assert entity.n == 5

      assert length(entity.vertexes) == 5

      assert entity.handle == "2352"
      assert entity.block == "234F"
      assert entity.class == "AcDbPolyline"
      assert entity.layer == "0"
      assert entity.color == 10
    end
  end
end
