defmodule TransactionList do
  def start_link(state) do
    Agent.start_link(fn() -> state end, [name: TxList])
  end
end
