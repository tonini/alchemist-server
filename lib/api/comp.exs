Code.require_file "../autocomplete.exs", __DIR__

defmodule Alchemist.API.Comp do

  @moduledoc false

  alias Alchemist.Autocomplete

  def process(request) when is_binary(request) do
    request
    |> normalize
    |> process
  end

  def process([nil, _, imports, _]) do
    Autocomplete.run('', imports) ++ Autocomplete.run('')
    |> print
  end

  def process([hint, _context, imports, aliases]) do
    Application.put_env(:"alchemist.el", :aliases, aliases)

    Autocomplete.run(hint, imports) ++ Autocomplete.run(hint)
    |> print
  end

  def normalize(request) do
    IO.inspect Code.eval_string(request)

    {{hint, [ context: context,
              imports: imports,
              aliases: aliases ]}, _} =  Code.eval_string(request)
    [hint, context, imports, aliases]
  end

  def print(result) do
    result
    |> Enum.uniq
    |> Enum.map &IO.puts/1
    IO.puts "END-OF-COMP"
  end
end
