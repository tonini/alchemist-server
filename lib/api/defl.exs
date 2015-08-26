Code.require_file "../source.exs", __DIR__

defmodule Alchemist.API.Defl do

  @moduledoc false

  alias Alchemist.Source

  def process(request) do
    request
    |> normalize
    |> Source.find
    |> IO.puts

    IO.puts "END-OF-DEFL"
  end

  def normalize(request) do
    {{expr, context_info}, _} = Code.eval_string(request)
    [module, function] = String.split(expr, ",", parts: 2)
    {module, _} = Code.eval_string(module)
    function = String.to_atom function
    [module, function, context_info]
  end
end
