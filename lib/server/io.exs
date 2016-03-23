defmodule Alchemist.Server.IO do

  @moduledoc false

  def gets do
    IO.gets("") |> String.rstrip()
  end

  def puts(line) do
    IO.puts line
  end

  def inspect(item) do
    IO.inspect item
  end
end
