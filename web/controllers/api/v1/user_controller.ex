defmodule Chowmonger.API.V1.UserController do
  use Chowmonger.Web, :controller
  alias Chowmonger.API.V1.User

  plug :scrub_params, "data" when action in [:update]

  def current(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> render(:show, data: user)
  end

  def show(conn, _) do
    case decode_and_verify_token(conn) do
      {:ok, _claims} ->
        user = Guardian.Plug.current_resource(conn)
        |> Repo.preload([{:truck, :menu_items}])

        conn
        |> put_status(:ok)
        |> render("show.json", data: user)
      {:error, _reason} ->
        conn
        |> put_status(:not_found)
        |> render("errors.json", data: "Not found")
    end
  end

  def update(conn, %{"data" => %{"attributes" => %{"email" => email, "name" => name}, "type" => "users", "id" => id}}) do
    user = Repo.get!(User, id)
           |> Ecto.Changeset.change(email: email)
           |> Ecto.Changeset.change(name: name)

    case Repo.update(user) do
      {:ok, user} ->
        user = user |> Repo.preload([{:truck, :menu_items}])

        conn
        |> put_status(:ok)
        |> render("show.json", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  defp decode_and_verify_token(conn) do
    conn
    |> Guardian.Plug.current_token
    |> Guardian.decode_and_verify
  end
end
