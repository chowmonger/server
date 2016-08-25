defmodule Chowmonger.API.V1.RegistrationController do
  use Chowmonger.Web, :controller

  alias Chowmonger.{Repo, API.V1.User}

  plug :scrub_params, "data" when action in [:create]

  def create(conn, %{"data" => %{"attributes" => attributes, "type" => "users"}}) do
    changeset = %User{}
                |> User.changeset(attributes)

    case Repo.insert(changeset) do
      {:ok, user} ->
        user = user |> Repo.preload([{:truck, :menu_items}])

        conn
        |> put_status(:created)
        |> render("show.json-api", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end
end
