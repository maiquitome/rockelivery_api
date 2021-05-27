defmodule Rockelivery.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:address, :age, :cep, :cpf, :email, :name, :password_hash]

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  def changeset(params_map) do
    %__MODULE__{}
    |> cast(params_map, @required_params)
  end
end
