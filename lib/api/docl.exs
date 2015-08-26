Code.require_file "../documentation.exs", __DIR__

defmodule Alchemist.API.Docl do

  @moduledoc false

  alias Alchemist.Documentation

  def process(request) when is_binary(request) do
    request
    |> normalize
    |> process
  end

  def process([expr, modules, aliases]) do
    Documentation.search(expr, modules, aliases)
    print
  end

  def normalize(request) do
    {{expr, [ context: _,
              imports: imports,
              aliases: aliases]}, _} = Code.eval_string(request)
    [expr, imports, aliases]
  end

  def print do
    IO.puts "END-OF-DOCL"
  end
end
