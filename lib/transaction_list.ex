defmodule TransactionList do
  def start_link(state) do
    Agent.start_link(fn() -> state end, [name: TxList])
  end

  def push(transaction) do
    Agent.update(TxList, fn(state) -> [transaction | state] end)
  end
end
