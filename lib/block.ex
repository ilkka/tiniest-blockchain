defmodule Block do
  @moduledoc """
  Blocks in the tiniest blockchain.
  """

  defstruct index: 0, timestamp: "", data: %{proof_of_work: 13, transactions: []}, previous_hash: "0", hash: "0"

  @doc """
  Generate the Genesis block.

  ## Examples:

      iex> g = Block.genesis
      iex> g.index
      0
      iex> g.previous_hash
      "0"
      iex> g.hash |> String.length
      64

  """
  def genesis() do
    %Block{timestamp: timestamp_now()} |> hash
  end

  @doc """
  Create a new block.

  Given data to store and the previous block, returns the new block.

  ## Examples:

      iex> g = Block.genesis()
      iex> b = Block.create("hello world", g)
      iex> b.data
      "hello world"
      iex> b.index
      1
      iex> b.hash |> String.length
      64
      iex> b.previous_hash == g.hash
      true
  """
  def create(data, %Block{index: prev_index, hash: prev_hash}) do
    %Block{
      index: prev_index + 1,
      timestamp: timestamp_now(),
      data: data,
      previous_hash: prev_hash
    }
    |> hash
  end

  defp hash(%Block{} = block) do
    %{
      block
      | hash: :crypto.hash(:sha256, [
                block.index,
                block.timestamp,
                inspect(block.data),
                block.previous_hash
              ])
              |> Base.encode16()
    }
  end

  defp timestamp_now do
    DateTime.utc_now() |> DateTime.to_iso8601()
  end
end
