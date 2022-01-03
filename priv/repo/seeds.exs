# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, Repo, User}

IO.puts("======Inserting user...======")

user = %User{
  age: 27,
  address: "RUa das banananeiras, 15",
  cep: "12345678",
  cpf: "98765432101",
  email: "rafaelbanana@frutas.com",
  password: "123456",
  name: "Rafael"
}

%User{id: user_id} = Repo.insert!(user)

IO.puts("======Inserting items...======")

item1 = %Item{
  category: :food,
  description: "banana frita",
  price: Decimal.new("15.50"),
  photo: "priv/photos/banana_frita.png"
}

item2 = %Item{
  category: :food,
  description: "banana cozida",
  price: Decimal.new("10.50"),
  photo: "priv/photos/banana_cozida.png"
}

Repo.insert!(item1)
Repo.insert!(item2)

IO.puts("======Inserting orders...======")

order = %Order{
  user_id: user_id,
  items: [item1, item1, item2],
  address: "Rua das bananeiras, 15",
  comments: "sem canela",
  payment_method: :money
}

Repo.insert!(order)
IO.puts("======DONE!======")
