Code.require_file "../test_helper.exs", __DIR__
Code.require_file "../../lib/api/comp.exs", __DIR__
Code.require_file "../../lib/server/io.exs", __DIR__

defmodule Alchemist.API.CompTest do

  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias Alchemist.API.Comp
  alias Alchemist.Server.IO, as: ServerIO

  test "COMP request with empty hint" do
    assert capture_io(fn ->
      Comp.process([nil, Elixir, [], [] ], ServerIO)
    end) =~ """
    import/2
    quote/2
    require/2
    END-OF-COMP
    """
  end

  test "COMP request without empty hint" do
    assert capture_io(fn ->
      Comp.process(['is_b', Elixir, [], []], ServerIO)
    end) =~ """
    is_b
    is_binary/1
    is_bitstring/1
    is_boolean/1
    END-OF-COMP
    """
  end

  test "COMP request with an alias" do
    assert capture_io(fn ->
      Comp.process(['MyList.flat', Elixir, [], [{MyList, List}]], ServerIO)
    end) =~ """
    MyList.flatten
    flatten/1
    flatten/2
    END-OF-COMP
    """
  end

  test "COMP request with a module hint" do
    assert capture_io(fn ->
      Comp.process(['Str', Elixir, [], []], ServerIO)
    end) =~ """
    Str
    Stream
    String
    StringIO
    END-OF-COMP
    """
  end

end
