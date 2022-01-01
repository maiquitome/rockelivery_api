defmodule Rockelivery.Orders.CalculatesTotalPrice do
  alias Rockelivery.Item

  def call(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_prices/2)
  end

  def sum_prices(%Item{price: price}, acc), do: Decimal.add(price, acc)
end
