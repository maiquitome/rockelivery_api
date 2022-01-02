defmodule Rockelivery.Users.Delete do
  @moduledoc """
  Delete an user from the database.
  """

  alias Rockelivery.{Error, Repo, User}

  @spec call(binary) ::
          {:error, %{result: String.t(), status: :not_found}}
          | {:ok, Ecto.Struct.t()}
          | {:error, Ecto.Changeset.t()}
  @doc """
  Delete an user from the database.

  ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "12345678910",
      email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, %Rockelivery.User{} = user} = Rockelivery.create_user(user_params)

      iex> {:ok, %Rockelivery.User{}} = Rockelivery.Users.Delete.call(user.id)

  """
  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> Repo.delete(user_schema)
    end
  end
end
