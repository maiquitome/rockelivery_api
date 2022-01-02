defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}

  @type user_params :: %{
          address: String.t(),
          age: integer,
          cep: String.t(),
          cpf: String.t(),
          email: String.t(),
          name: String.t(),
          password: String.t()
        }

  @doc """
  Inserts an user into the database.

  ## Examples

      iex> user_params = %{
        address: "Rua...", age: 28,
        cep: "12345678", cpf: "12345678910",
        email: "teste_teste@teste.com",
        name: "Maiqui Tomé",
        password: "123456"
      }

      iex> Rockelivery.Users.Create.call(user_params)
      {:ok, %Rockelivery.User{}}

  """
  @spec call(user_params()) ::
          {:error,
           Struct.t(
             result: Ecto.Changeset.t() | String.t() | atom(),
             status: :bad_request | :not_found
           )}
          | {:ok, User.t()}
  def call(%{} = params) do
    # o nil não precisaria colocar porque já é nil por padrão
    cep = Map.get(params, "cep", nil)

    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %{} = _cep_info} <- client().get_cep_info(cep),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  def call(_anything), do: {:error, "Enter the data in a map format"}

  defp client do
    # Application.fetch_env!(:rockelivery, __MODULE__)[:via_cep_adapter]
    :rockelivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end
end
