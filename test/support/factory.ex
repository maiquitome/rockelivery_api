defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 27,
      "address" => "Rua do Maiqui",
      "cep" => "12345678",
      "cpf" => "12345678901",
      "email" => "maiqui@tome.com.br",
      "password" => "123456",
      "name" => "Maiqui Tomé"
    }
  end

  def user_factory do
    %User{
      age: 27,
      address: "Rua do Maiqui",
      cep: "12345678",
      cpf: "12345678901",
      email: "maiqui@tome.com.br",
      password: "123456",
      name: "Maiqui Tomé",
      id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
    }
  end
end
