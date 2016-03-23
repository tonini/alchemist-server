defmodule Alchemist.API.Eval do

  @moduledoc false

  def request(args, io_module) do
    args
    |> normalize
    |> process(io_module)

    io_module.puts "END-OF-EVAL"
  end

  def process({:eval, file}, io_module) do
    try do
      File.read!("#{file}")
      |> Code.eval_string
      |> Tuple.to_list
      |> List.first
      |> io_module.inspect
    rescue
      e -> io_module.inspect e
    end
  end

  def process({:quote, file}, io_module) do
    try do
      File.read!("#{file}")
      |> Code.string_to_quoted
      |> Tuple.to_list
      |> List.last
      |> io_module.inspect
    rescue
      e -> io_module.inspect e
    end
  end

  def process({:expand, file}, io_module) do
    try do
      {_, expr} = File.read!("#{file}")
      |> Code.string_to_quoted
      res = Macro.expand(expr, __ENV__)
      io_module.puts Macro.to_string(res)
    rescue
      e -> io_module.inspect e
    end
  end

  def process({:expand_once, file}, io_module) do
    try do
      {_, expr} = File.read!("#{file}")
      |> Code.string_to_quoted
      res = Macro.expand_once(expr, __ENV__)
      io_module.puts Macro.to_string(res)
    rescue
      e -> IO.inspect e
    end
  end

  def normalize(request) do
    {expr , _} = Code.eval_string(request)
    expr
  end
end
