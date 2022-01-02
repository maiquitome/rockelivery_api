defmodule Rockelivery.Users.Update do
  @moduledoc """
  Update an user from the database.
  """
  alias Ecto.Changeset
  alias Rockelivery.{Error, Repo, User}

  @doc """
  Update an user from the database.

  ## Examples

    * create user

          iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "12345678910",
          email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

          iex> {:ok, %Rockelivery.User{} = user} = Rockelivery.create_user(user_params)

    * update user

          iex> update_params = %{"id" => "482f95a7-b447-42e9-ae67-aef72954c3f0", "name" => "Maiqui Tomé"}

          iex> {:ok, %Rockelivery.User{}} = Rockelivery.Users.Update.call update_params

  """
  @spec call(%{id: integer}) ::
          {:error, Struct.t(result: String.t(), status: :not_found)}
          | {:ok, Struct.t()}
          | {:error, Changeset.t()}
  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user_schema -> do_update(user_schema, params)
    end
  end

  defp do_update(%User{} = user, %{} = params) do
    user
    |> User.changeset_to_update(params)
    |> Repo.update()
  end
end
