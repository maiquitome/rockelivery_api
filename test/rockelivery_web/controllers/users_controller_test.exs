defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua do Maiqui",
                 "age" => 27,
                 "cep" => "12345678",
                 "cpf" => "12345678901",
                 "email" => "maiqui@tome.com.br",
                 "id" => _id,
                 "name" => "Maiqui Tomé"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{"name" => "Maiqui Tomé"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"],
          "password" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is an user with the given id, deletes the user", %{conn: conn} do
      id = "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
      # inserindo a struct user no banco
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
