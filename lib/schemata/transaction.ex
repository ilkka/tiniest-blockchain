defmodule Schemata.Transaction do
  @schema %{
      "type" => "object",
      "properties" => %{
        "from" => %{"type" => "string"},
        "to" => %{"type" => "string"},
        "amount" => %{"type" => "number", "minimum" => 0, "exclusiveMinimum" => :true}
      },
      "required" => ["from", "to", "amount"]
    } |> ExJsonSchema.Schema.resolve

  def schema do
    @schema
  end
end
