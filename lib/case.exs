Code.require_file "documentation.exs", __DIR__
Code.require_file "autocomplete.exs", __DIR__

defmodule Alchemist.Case do
  @moduledoc false

  alias Alchemist.Autocomplete
  alias Alchemist.Informant
  alias Alchemist.Documentation

  defmodule Modules do
    def process do
      modules = Informant.all_applications_modules
      |> Enum.uniq
      |> Enum.reject(&is_nil/1)
      |> Enum.filter(&Documentation.moduledoc?/1)

      functions = Autocomplete.run('')
      print(modules ++ functions)
    end

    def print(result) do
      result
      |> Enum.uniq
      |> Enum.map &IO.puts/1
      IO.puts "END-OF-MODULES"
    end
  end

  defmodule Eval do
    def process(file) do
      try do
        File.read!("#{file}")
        |> Code.eval_string
        |> Tuple.to_list
        |> List.first
        |> IO.inspect
      rescue
        e -> IO.inspect e
      end
      IO.puts "END-OF-EVAL"
    end
  end

  defmodule Quote do
    def process(file) do
      try do
        File.read!("#{file}")
        |> Code.string_to_quoted
        |> Tuple.to_list
        |> List.last
        |> IO.inspect
      rescue
        e -> IO.inspect e
      end
      IO.puts "END-OF-QUOTE"
    end
  end

  defmodule MixTask do
    def process do
      # append things like hex or phoenix archives to the load_path
      Mix.Local.append_archives

      tasks =
        Mix.Task.load_tasks(:code.get_path)
        |> Enum.map(&Mix.Task.task_name/1)

      for info <- Enum.sort(tasks) do
        IO.puts info
      end

      IO.puts "END-OF-MIXTASKS"
    end
  end
end
