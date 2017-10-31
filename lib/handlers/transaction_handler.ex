defmodule Handlers.TransactionHandler do
  require Logger
  use Plug.Router

  plug Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Poison
  plug :match
  plug :dispatch

  post "/" do
    Logger.info("Handling transaction POST request")

    new_tx = conn.body_params
    if ExJsonSchema.Validator.valid?(Transaction.schema, new_tx) do
      :ok = TransactionList.push(new_tx)
      send_resp(conn, 200, "accepted")
    else
      send_resp(conn, 400, "bad transaction")
    end
  end
end
