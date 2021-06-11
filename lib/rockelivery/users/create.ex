defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}

  @spec call(%{}) ::
          {:error, %{result: Ecto.Changeset.t(), status: :internal_server_error}}
          | {:ok, %Rockelivery.User{}}
  @doc """
  Inserts an user into the database.

      ## Examples

      iex> user_params = %{address: "Rua...", age: 28, cep: "12345678", cpf: "12345678910", email: "teste_teste@teste.com", name: "Maiqui Tomé", password: "123456"}

      iex> {:ok, user_schema} = Rockelivery.Users.Create.call(user_params)

  """
  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def call(_anything), do: "Enter the data in a map format"

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
