defmodule Dxf.EntityCase do
  @moduledoc """
  This module defines the test case to be used by
  entity tests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Dxf.EntityCase
      import Dxf.Type.Entity, only: [parse: 1]

      alias Dxf.Type.Point
    end
  end

  defmacro test_entity(entity, comment \\ "", data, do: do_block) do
    quote do
      test "parses #{unquote(entity)} entity data #{unquote(comment)} correctly" do
        {var!(entity), rest} =
          unquote(data)
          |> String.split("\n", trim: false)
          |> Enum.map(&String.trim/1)
          |> parse()

        assert var!(entity).__struct__ == unquote(entity)

        unquote(do_block)

        assert rest == []
      end
    end
  end
end
