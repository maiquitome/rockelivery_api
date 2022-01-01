defmodule RockeliveryWeb.Auth.ErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  # auth_error(conn, {:unauthenticate, :unauthenticate}, _opts)
  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(error)})

    # 401 unauthorized
    send_resp(conn, 401, body)
  end
end
