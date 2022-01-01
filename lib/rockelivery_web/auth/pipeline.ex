defmodule RockeliveryWeb.Auth.Pipeline do
  # define que é um pipeline
  use Guardian.Plug.Pipeline, otp_app: :rockelivery

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  # injeta o claims na conexão:
  plug Guardian.Plug.LoadResource
end
