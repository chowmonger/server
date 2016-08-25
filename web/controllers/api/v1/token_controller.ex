defmodule Chowmonger.API.V1.TokenController do
  use Chowmonger.Web, :controller

  alias Chowmonger.API.V1.TokenView
  alias Chowmonger.API.V1.TokenController
  alias Guardian.Plug.EnsurePermissions

  plug :scrub_params, "data" when action in [:create]

  plug EnsurePermissions, [handler: TokenController] when action in [:show]

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json-api", data: user)
  end

  def create(conn, %{"data" => %{"attributes" => token_params }}) do
    case Chowmonger.Token.authenticate(token_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)
        user = Map.put_new(user, :jwt, jwt)

        conn
        |> put_status(:created)
        |> render("show.json-api", data: user)
      :error ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: %{detail: "Invalid Credentials"})
    end
  end

  # called from Guardian.Plug.EnsureAuthenticated
  def unauthenticated(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render(TokenView, "forbidden.json", error: "Not Authenticated")
  end

  def unauthorized(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render(TokenView, "forbidden.json", error: "Not Authorized")
  end
end
