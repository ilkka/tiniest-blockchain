defmodule TiniestBlockchain do
  use Application

  def start(_type, _args) do
    # dispatch = build_dispatch()
    children = [
      %{
        id: TransactionList,
        start: {TransactionList, :start_link, [[]]}
      },
      # %{
      #   id: HttpServer,
      #   start: {:cowboy, :start_clear, [:http, [{:port, 8080}], %{:env => %{:dispatch => dispatch}}]}
      # }
      Plug.Adapters.Cowboy.child_spec(:http, Router, [], [port: 8080])
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  # def build_dispatch() do
  #   :cowboy_router.compile([
  #     {:_, [{"/transaction", Handlers.TransactionHandler, []}]}
  #   ])
  # end
end
