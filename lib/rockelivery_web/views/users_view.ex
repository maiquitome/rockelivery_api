defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created!",
      token: token,
      user: user
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{
      message: "user successfully logged in!",
      token: token
    }
  end

  def render("user.json", %{user: %User{} = user}) do
    %{
      message: "user found successfully!",
      user: user
    }
  end
end
