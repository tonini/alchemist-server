defmodule Alchemist.API.Ping do

  @moduledoc false

  def request(io_module) do
    process(io_module)
  end

  def process(io_module) do
    io_module.puts "PONG"
    io_module.puts "END-OF-PING"
  end
end
