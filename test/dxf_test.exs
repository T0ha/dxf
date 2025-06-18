defmodule DxfTest do
  use ExUnit.Case
  doctest Dxf

  test "greets the world" do
    assert %Dxf{} =
             Dxf.parse_file("../../data/project_part.dxf")
             |> IO.inspect(limit: :infinity, pretty: true)
  end
end
