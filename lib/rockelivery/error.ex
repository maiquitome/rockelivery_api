defmodule Rockelivery.Error do
  alias Ecto.Changeset
  alias Rockelivery.Error

  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  @spec build(atom(), String.t() | Changeset.t()) :: %Error{
          result: String.t() | Changeset.t(),
          status: atom()
        }
  @doc """
  Build error messages.
  """
  def build(status, result) do
    %__MODULE__{
      result: result,
      status: status
    }
  end

  @doc """
  Error default message for status :not_found.
  """
  @spec build_user_not_found :: %Error{
          result: String.t(),
          status: :not_found
        }
  def build_user_not_found, do: build(:not_found, "User not found")
end
