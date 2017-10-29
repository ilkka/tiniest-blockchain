defmodule TiniestBlockchain do
  def start(_type, _args) do
    dispatch = build_dispatch()
    {:ok, _} = :cowboy.start_clear(:http, [{:port, 8080}], %{:env => %{:dispatch => dispatch}})
  end

  def build_dispatch() do
    :cowboy_router.compile([
      {:_, [{"/transaction", Handlers.TransactionHandler, []}]}
    ])
  end
end
