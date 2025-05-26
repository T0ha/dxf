defmodule Dxf.Type.Entity.Text do
  @moduledoc """
  A module for handling points in DXF files.
  """
  alias Dxf.Type.Point

  @behaviour Dxf.Type.Entity

  @type t() :: %__MODULE__{
    text: String.t(),
    alignmnt_point: Point.t(),
    rotation_angle: float(),
    relative_scale_factor: float(),
    text_style: String.t(),
    height: float(),
    second_alignmnt_point: Point.t(),
    text_generation_flag: integer(),
    horizontal_text_justification: integer(),
    vertical_text_justification: integer(),
    thickness: float()
  }

  defstruct [
    :text,
    :alignmnt_point,
    :rotation_angle,
    :relative_scale_factor,
    :text_style,
    :height,
    :second_alignmnt_point,
    :text_generation_flag,
    :horizontal_text_justification,
    :vertical_text_justification,
    :thickness
  ]


  @entity "0"

  @text "1"
  @alignmnt_point "10"
  @height "40"
  @rotation_angle "50"
  @relative_scale_factor "41"
  @text_style "7"
  @second_alignmnt_point "11"
  @text_generation_flag "71"
  @horizontal_text_justification "72"
  @vertical_text_justification "73"
  @thickness "39"


  @doc """
  Parses a point from a list of strings.
  """
  @impl true
  @spec parse([String.t()], %__MODULE__{}) :: {t(), [String.t()]}
  def parse([@entity | _] = rest, acc), do: {acc, rest}
  def parse([@text, text | rest], acc) do
    parse(rest, %{acc | text: text})
  end
  def parse([@alignmnt_point | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | alignmnt_point: point})
  end
  def parse([@rotation_angle, angle | rest], acc) do
    parse(rest, %{acc | rotation_angle: String.to_float(angle)})
  end
  def parse([@relative_scale_factor, factor | rest], acc) do
    parse(rest, %{acc | relative_scale_factor: String.to_float(factor)})
  end
  def parse([@text_style, style | rest], acc) do
    parse(rest, %{acc | text_style: style})
  end
  def parse([@height, height | rest], acc) do
    parse(rest, %{acc | height: String.to_float(height)})
  end
  def parse([@second_alignmnt_point | _] = data, acc) do
    {point, rest} = Point.parse(data)
    parse(rest, %{acc | second_alignmnt_point: point})
  end
  def parse(rest, acc), do: {acc, rest}
end
