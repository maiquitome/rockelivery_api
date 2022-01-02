defmodule Rockelivery.Items.Create do
  alias Rockelivery.{Error, Item, Repo}

  @typedoc """
  Item params.
  """
  @type item_params :: %{
          category: Ecto.Enum.t(),
          price: Decimal.t(),
          description: String.t(),
          photo: String.t()
        }

  @doc """
  Inserts an item into the database.

  ## Examples

      iex> item_params = %{
          category: :food,
          price: "12.50",
          description: "Cheeseburguer",
          photo: "/priv/cheeseburguer.jpg"
      }

      iex> Rockelivery.Items.Create.call(item_params)
      {:ok, %Rockelivery.Item{}}

      iex> Rockelivery.Items.Create.call(%{})
      {:error, %Rockelivery.Error{result: %Ecto.Changeset{}, status: :bad_request}}

  """
  @spec call(item_params) ::
          {:error, String.t()}
          | {:error, %{result: Ecto.Changeset.t(), status: atom()}}
          | {:ok, Ecto.Struct.t()}
  def call(%{} = params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def call(_anything), do: {:error, "Enter the data in a map format"}

  defp handle_insert({:ok, %Item{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
