defmodule Rockelivery.Users.Create do
  alias Rockelivery.{User, Repo}

  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

  def call(_anything), do: "Enter the data in a map format"
end
