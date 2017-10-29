defmodule Handlers.TransactionHandler do
  require Logger

  def init(req, state) do
    handle(req, state)
  end

  def handle(%{:method => "POST"} = req, state) do
    Logger.info "Handling transaction POST request"
    {:ok, body, req} = :cowboy_req.read_body(req)
    new_tx = Poison.decode!(body)
    Logger.info inspect(new_tx)
    reply = :cowboy_req.reply(200, %{"content-type" => "text/plain"}, "morjesta", req)
    {:ok, reply, state}
  end

  def handle(req, state) do
    Logger.info "Handling other transaction request"
    reply = :cowboy_req.reply(404, %{"content-type" => "text/plain"}, "not found", req)
    {:ok, reply, state}
  end
end
