Code.require_file "test_helper.exs", __DIR__
Code.require_file "../lib/api/comp.exs", __DIR__
Code.require_file "../lib/api/docl.exs", __DIR__

defmodule APITest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias Alchemist.API

  test "COMP request with empty hint" do
    assert capture_io(fn ->
      API.Comp.process([nil, Elixir, [], [] ])
    end) =~ """
    defexception/1
    defoverridable/1
    defstruct/1
    """
  end

  test "COMP request without empty hint" do
    assert capture_io(fn ->
      API.Comp.process(['is_', Elixir, [], []])
    end) =~ """
    is_atom/1
    is_binary/1
    """
  end

  test "DOCL request" do
    assert capture_io(fn ->
      API.Docl.process(['defmodule', [], []])
    end) =~ """
    Defines a module given by name with the given contents.
    """
  end

end
