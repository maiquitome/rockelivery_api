defmodule RockeliveryWeb.Auth.Guardian do
  use Guardian, otp_app: :rockelivery

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}
  def subject_for_token(_, _), do: {:error, "Unknown resource type"}

  def resource_from_claims(%{"sub" => id}), do: {:ok, UserGet.by_id(id)}
  def resource_from_claims(_claims), do: {:error, "Unknown resource type"}

  @doc """
    ### Example:
      iex> credentials = %{
        "id" => "1acfa1a9-924a-4c7f-9540-381121757000",
        "password" => "123456"
      }

      iex> RockeliveryWeb.Auth.Guardian.authenticate(credentials)
      {:ok, token}

    ### Error example:
      iex> credentials = %{"id" => "1acfa1a9-924a-4c7f-9540-381121757000"}

      iex> RockeliveryWeb.Auth.Guardian.authenticate(credentials)
      {
        :error,
        %Rockelivery.Error{
          result: "Invalid or missing params",
          status: :bad_request
        }
      }
  """
  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
         true <- Argon2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      any -> any
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}
end
