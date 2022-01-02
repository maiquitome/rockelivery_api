defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.{Error, Item, Order, Repo}
  alias Rockelivery.Orders.ValidateAndMultiplyItems

  @doc """
  Inserts an order into the database.

  ## Examples

      iex> params = %{"items" => [
          %{
            "id" => "76e8932e-f1f0-4f29-afc9-17ef6c4c2b8f",
            "quantity" => 2
          },
          %{
            "id" => "c28c4c26-3592-47d2-a37d-6a5c8a054dfd",
            "quantity" => 1
          }
        ],
        "user_id" => "c7e78762-ad24-4aa3-86dc-48ab0c9fa4f1",
        "address" => "Rua das Bananeiras, 222",
        "payment_method" => "money",
        "comments" => "maionese extra"
      }

      iex> Rockelivery.Orders.Create.call(params)
      {:ok, %Rockelivery.Order{}}

  """
  def call(%{"items" => items_params} = params) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(items_ids, items_params)
    |> handle_items(params)
  end

  def call(_anything), do: {:error, "Enter the data in a map format"}

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = result), do: result

  defp handle_insert({:error, %Ecto.Changeset{} = changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
