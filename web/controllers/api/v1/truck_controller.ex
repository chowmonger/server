defmodule Chowmonger.API.V1.TruckController do
  use Chowmonger.Web, :controller

  alias Chowmonger.{Repo, API.V1.Truck, API.V1.TokenController}
  alias Guardian.Plug.EnsureAuthenticated

  plug EnsureAuthenticated, [handler: TokenController] when action in [:update]

  plug :scrub_params, "data" when action in [:update]

  def index(conn, params) do
    trucks =
      case params do
        %{"name" => name} ->
          Repo.all(from t in Truck, where: ilike(t.name, ^"%#{name}%"))
          |> Repo.preload(:menu_items)
        _ ->
          Repo.all(Truck)
          |> Repo.preload(:menu_items)
      end

    render(conn, "index.json", data: trucks)
  end

  def show(conn, %{"id" => id}) do
    truck = Repo.get!(Truck, id) |> Repo.preload(:menu_items)
    render(conn, "show.json", data: truck)
  end

  def update(conn, %{"data" => %{"attributes" => truck_params}, "id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    truck = Repo.get!(user_trucks(user), id)
    changeset = Truck.changeset(truck, truck_params)

    case Repo.update(changeset) do
      {:ok, truck} ->
        Chowmonger.Endpoint.broadcast_from! self(), "trucks", "change", %{"id" => id}
        render(conn, "show.json", data: truck |> Repo.preload(:menu_items))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  defp user_trucks(user) do
    assoc(user, :truck)
  end
end
