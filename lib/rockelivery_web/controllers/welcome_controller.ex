defmodule RockeliveryWeb.WelcomeController do
  use RockeliveryWeb, :controller

  def index(conn, _params) do
    conn
    # |> IO.inspect(label: "WITHOUT STATUS!!!!!!!!!!!!!!!!!!!!!")
    |> Plug.Conn.put_status(:ok)
    |> Phoenix.Controller.text("Welcome :)")

    # |> Phoenix.Controller.json(%{message: params["id"]})
    # |> IO.inspect(label: "WITH STATUS!!!!!!!!!!!!!!!!!!!!!!!")
  end
end
