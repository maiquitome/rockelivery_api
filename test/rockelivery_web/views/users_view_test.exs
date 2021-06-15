defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %Rockelivery.User{
               address: "Rua do Maiqui",
               age: 27,
               cep: "12345678",
               cpf: "12345678901",
               email: "maiqui@tome.com.br",
               id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
               inserted_at: nil,
               name: "Maiqui Tomé",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
