defmodule Dxf.Type.Entity.InsertTest do
  use Dxf.EntityCase

  describe "Insert entity" do
    test_entity Dxf.Type.Entity.Insert,
                ~S(0
      INSERT
      5
      1444
      330
      1442
      100
      AcDbEntity
      8
      0
      6
      Continuous
      100
      AcDbBlockReference
      2
      A$C628F35D4
      10
      -0.0000002043748282
      20
      -0.0000013985243186
      30
      0.0) do
      assert entity.handle == "1444"
      assert entity.block == "1442"
      assert entity.class == "AcDbBlockReference"
      assert entity.layer == "0"
      assert entity.color == nil
      assert entity.linetype == "Continuous"

      assert entity.insertion_point == %Point{
               x: -0.0000002043748282,
               y: -0.0000013985243186,
               z: 0.0
             }

      assert entity.block_name == "A$C628F35D4"
    end
  end
end
