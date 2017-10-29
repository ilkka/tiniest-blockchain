defmodule Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  forward "/transaction", to: Handlers.TransactionHandler

  match _ do
    send_resp(conn, 404, "not found")
  end
end
