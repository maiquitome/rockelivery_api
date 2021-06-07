defmodule Rockelivery.Users.Create do
  alias Rockelivery.{User, Repo}

  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def call(_anything), do: "Enter the data in a map format"

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, %{status: :internal_server_error, result: changeset}}
  end
end
