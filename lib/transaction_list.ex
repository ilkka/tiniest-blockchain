defmodule TransactionList do
  def start_link(state) do
    Agent.start_link(fn() -> state end, [name: TxList])
  end

  def push(transaction) do
    Agent.update(TxList, fn(state) ->
      txs = [transaction | state]
      if length(txs) > 9 do
        Blockchain.mine(txs)
        []
      else
        txs
      end
    end)
  end
end
