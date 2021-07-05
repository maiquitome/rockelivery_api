defmodule Rockelivery.Item do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rockelivery.Order

  @fields_that_can_be_changed [
    :category,
    :price,
    :description,
    :photo
  ]

  @required_fields [
    :category,
    :price,
    :description,
    :photo
  ]

  @primary_key {:id, :binary_id, autogenerate: true}

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "items" do
    field :category, Ecto.Enum, values: [:food, :drink, :desert]
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, %{} = params) do
    struct
    |> cast(params, @fields_that_can_be_changed)
    |> validate_required(@required_fields)
    |> validate_length(:description, min: 2)
    |> validate_number(:price, greater_than: 0)
  end
end
