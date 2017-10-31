defmodule Blockchain do
  @miner_address "9834798ryg-this-miners-address-29385w9"

  def start_link(state) do
    Agent.start_link(fn() -> state end, [name: BlockChain])
  end

  @spec mine([%Transaction{}]) :: :ok
  def mine(transactions) do
    Agent.update(BlockChain, fn(state) ->
      [%{data: last_block_data} = last_block | _] = state
      %{proof_of_work: last_block_proof} = last_block_data
      new_proof = prove_work(last_block_proof)
      [Block.create(%{
        proof_of_work: new_proof,
        transactions: [%Transaction{from: "network", to: @miner_address, amount: 1} | transactions]
      }, last_block) | state]
    end, :infinity)
  end

  defp prove_work(last_proof) do
    Stream.iterate(last_proof + 1, &(&1 + 1))
    |> Enum.take_while(fn(x) -> rem(x, 9) + rem(x, last_proof) > 0 end)
    |> List.last
    |> (&(&1 + 1)).()
  end
end
