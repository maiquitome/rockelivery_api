defmodule RockeliveryWeb.Plugs.UUIDChecker do
  import Plug.Conn

  alias Ecto.UUID
  alias Plug.Conn

  # init/1 inicializa quaisquer argumentos ou opções a serem passadas para call/2
  def init(options), do: options

  # call/2 é uma Function Plug que realiza a transformação da conexão.
  # Toda Function Plug precisa aceitar uma estrutura de conexão %Plug.Conn{} e opções.
  def call(%Conn{params: %{"id" => id}} = conn, _opts) do
    case UUID.cast(id) do
      :error -> render_error(conn)
      # se o ID for um UUID a conexão (conn) pode ir para o controller:
      {:ok, _uuid} -> conn
    end
  end

  # Caso não tenha id nos paramêtros, como na rota create,
  # continua enviando a conexão no fluxo normal
  def call(conn, _opts), do: conn

  defp render_error(conn) do
    body = Jason.encode!(%{message: "Invalid UUID"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
