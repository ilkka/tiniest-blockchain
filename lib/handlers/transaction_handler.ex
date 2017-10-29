defmodule Handlers.TransactionHandler do
  require Logger

  def init(req, state) do
    handle(req, state)
  end

  def handle(%{:method => "POST"} = req, state) do
    Logger.info("Handling transaction POST request")

    reply =
      if :cowboy_req.has_body(req) do
        {:ok, body, req} = :cowboy_req.read_body(req)
        new_tx = Poison.decode!(body)
        if ExJsonSchema.Validator.valid?(Schemata.Transaction.schema, new_tx) do
          :ok = TransactionList.push(new_tx)
          :cowboy_req.reply(200, %{"content-type" => "text/plain"}, "accepted", req)
        else
          :cowboy_req.reply(400, %{"content-type" => "text/plain"}, "bad transaction", req)
        end
      else
        :cowboy_req.reply(400, %{"content-type" => "text/plain"}, "not a transaction", req)
      end

    {:ok, reply, state}
  end

  def handle(req, state) do
    Logger.info("Handling other transaction request")
    reply = :cowboy_req.reply(404, %{"content-type" => "text/plain"}, "not found", req)
    {:ok, reply, state}
  end
end
