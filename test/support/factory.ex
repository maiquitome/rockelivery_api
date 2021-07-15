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

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
