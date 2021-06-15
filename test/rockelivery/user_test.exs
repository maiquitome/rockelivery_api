defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    # Primerio Cenário
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Maiqui Tomé"}, valid?: true} = response
    end

    # Segundo Cenário
    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{name: "Mike Wazowski"}

      changeset_with_current_data = User.changeset(params)

      response = User.changeset(changeset_with_current_data, update_params)

      assert %Changeset{changes: %{name: "Mike Wazowski"}, valid?: true} = response
    end

    # Terceiro Cenário
    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params, %{"age" => 17, "password" => "123"})

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
