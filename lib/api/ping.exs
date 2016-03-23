defmodule Alchemist.API.Ping do

  @moduledoc false

  def request do
    process
  end

  def process do
    IO.puts "PONG"
    IO.puts "END-OF-PING"
  end
end
