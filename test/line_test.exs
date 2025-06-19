defmodule Dxf.Type.Entity.LineTest do
  use ExUnit.Case, async: true
  alias Dxf.Type.Point
  alias Dxf.Type.Entity
  alias Dxf.Type.Entity.Line

  @data ~S(0
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
    0.0)

  describe "Line entity" do
    test "parses entity data correctly" do
      {entity, []} =
        @data
        |> String.split("\n", trim: false)
        |> Enum.map(&String.trim/1)
        |> Entity.parse()

      assert entity.__struct__ == Line
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
