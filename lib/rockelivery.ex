defmodule Rockelivery do
  @moduledoc """
  Rockelivery keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Ecto.Changeset
  alias Rockelivery.User
  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Get, as: UserGet
  alias Rockelivery.Users.Update, as: UserUpdate

  @spec create_user(%{}) ::
          {:error, %{result: Ecto.Changeset.t(), status: :internal_server_error}}
          | {:ok, %User{}}
  @doc """
  Inserts an user into the database.

      ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "12345678910", email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, user_schema} = Rockelivery.create_user(user_params)

  """
  defdelegate create_user(params), to: UserCreate, as: :call

  @spec get_user_by_id(binary) ::
          {:error, %{result: String.t(), status: :not_found}}
          | {:ok, %User{}}
  @doc """
  Gets an user by id in the database.

  ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "12345678910", email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, user_schema} = Rockelivery.create_user(user_params)

      iex> {:ok, _user_schema} = Rockelivery.get_user_by_id(user_schema.id)

  """
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id

  @spec delete_user(binary) ::
          {:error, %{result: String.t(), status: :not_found}}
          | {:ok, %User{}}
          | {:error, %Changeset{}}
  @doc """
  Delete an user from the database.

  ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "12345678910",
      email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, %Rockelivery.User{} = user} = Rockelivery.create_user(user_params)

      iex> {:ok, %Rockelivery.User{}} = Rockelivery.delete_user(user.id)

  """
  defdelegate delete_user(id), to: UserDelete, as: :call

  defdelegate update_user(params), to: UserUpdate, as: :call
end
