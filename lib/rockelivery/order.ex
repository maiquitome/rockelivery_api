defmodule Rockelivery.Order do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rockelivery.{Item, User}

  @fields_that_can_be_changed [
    :address,
    :comments,
    :payment_method,
    :user_id
  ]

  @required_fields [
    :address,
    :comments,
    :payment_method,
    :user_id
  ]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @derive {Jason.Encoder, only: @required_fields ++ [:id, :items]}

  schema "orders" do
    field :address, :string
    field :comments, :string
    field :payment_method, Ecto.Enum, values: [:money, :credit_card, :debit_card]

    belongs_to :user, User
    many_to_many :items, Item, join_through: "orders_items"

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, %{} = params, items) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(@required_fields)
    |> put_assoc(:items, items)
    |> validate_length(:address, min: 5)
    |> validate_length(:comments, min: 2)
  end
end
