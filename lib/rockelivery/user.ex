defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rockelivery.Order

  @fields_that_can_be_changed [
    :address,
    :age,
    :cep,
    :cpf,
    :email,
    :name,
    :password
  ]

  @required_fields [
    :address,
    :age,
    :cep,
    :cpf,
    :email,
    :name,
    :password
  ]

  @primary_key {:id, :binary_id, autogenerate: true}

  @derive {Jason.Encoder,
           only: [
             :id,
             :address,
             :age,
             :cep,
             :cpf,
             :email,
             :name
           ]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :orders, Order

    timestamps()
  end

  def build(changeset), do: apply_action(changeset, :insert)

  def changeset_to_update(struct, %{} = params) do
    changeset(struct, params, @required_fields -- [:password])
  end

  def changeset(struct \\ %__MODULE__{}, %{} = params, fields \\ @required_fields) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
