defmodule Rockelivery.Users.Get do
  @moduledoc """
  Gets the users in the database.
  """
  alias Ecto.UUID
  alias Rockelivery.{Repo, User}

  @spec by_id(binary) ::
          {:error, %{result: String.t(), status: :bad_request}}
          | {:error, %{result: String.t(), status: :not_found}}
          | {:ok, %User{}}
  @doc """
  Gets an user by id in the database.

  ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "123456789100", email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, user_schema} = Rockelivery.create_user(user_params)

      iex> {:ok, _user_schema} = Rockelivery.Users.Get.by_id(user_schema.id)

  """
  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, %{status: :bad_request, result: "Invalid Format!"}}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(id) do
    case Repo.get(User, id) do
      nil -> {:error, %{status: :not_found, result: "User not found!"}}
      user_schema -> {:ok, user_schema}
    end
  end
end
