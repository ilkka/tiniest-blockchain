defmodule TiniestBlockchainTest do
  use ExUnit.Case
  doctest TiniestBlockchain

  test "greets the world" do
    assert TiniestBlockchain.hello() == :world
  end
end
