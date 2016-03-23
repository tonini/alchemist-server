defmodule Alchemist.API.Ping do

  @moduledoc false

  def request do
    IO.puts "PONG"
    IO.puts "END-OF-PING"
  end
end
