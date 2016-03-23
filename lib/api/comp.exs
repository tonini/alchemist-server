Code.require_file "../helpers/complete.exs", __DIR__

defmodule Alchemist.API.Comp do

  @moduledoc false

  alias Alchemist.Helpers.Complete

  def request(args, io_module) do
    args
    |> normalize
    |> process(io_module)
  end

  def process([nil, _, imports, _], io_module) do
    Complete.run('', imports) ++ Complete.run('')
    |> print(io_module)
  end

  def process([hint, _context, imports, aliases], io_module) do
    Application.put_env(:"alchemist.el", :aliases, aliases)

    Complete.run(hint, imports) ++ Complete.run(hint)
    |> print(io_module)
  end

  defp normalize(request) do
    {{hint, [ context: context,
              imports: imports,
              aliases: aliases ]}, _} =  Code.eval_string(request)
    [hint, context, imports, aliases]
  end

  defp print(result, io_module) do
    result
    |> Enum.uniq
    |> Enum.map(&io_module.puts/1)

    io_module.puts "END-OF-COMP"
  end
end
