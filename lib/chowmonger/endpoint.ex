defmodule Chowmonger.Endpoint do
  use Phoenix.Endpoint, otp_app: :chowmonger

  socket "/socket", Chowmonger.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :chowmonger, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_chowmonger_key",
    signing_salt: "dabQbB6M"

  plug CORSPlug, origin: ["https://www.chowmonger.com", "http://localhost:4200", "https://chowmonger-client.herokuapp.com", "https://chowmonger.herokuapp.com"]
  plug Chowmonger.Router
end
