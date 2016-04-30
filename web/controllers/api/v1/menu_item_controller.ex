defmodule Chowmonger.API.V1.MenuItemController do
  use Chowmonger.Web, :controller

  alias Chowmonger.API.V1.MenuItem
  alias Chowmonger.API.V1.Truck

  plug :scrub_params, "data" when action in [:create, :update]

  def create(conn, %{"data" => menu_item_params}) do
    %{"attributes" => menu_item } = menu_item_params
    %{"relationships" => %{"truck" => %{"data" => %{"id" => truck_id}}}} = menu_item_params
    changeset = Repo.get(Truck, truck_id)
                |> Ecto.build_assoc(:menu_items)
                |> MenuItem.changeset(menu_item)

    case Repo.insert(changeset) do
      {:ok, menu_item} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", menu_item_path(conn, :show, menu_item))
        |> render("show.json", data: menu_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    menu_item = Repo.get!(MenuItem, id)
    render(conn, "show.json", data: menu_item)
  end

  def update(conn, %{"data" => %{"attributes" => menu_item_params}, "id" => id}) do
    menu_item = Repo.get!(MenuItem, id)
    changeset = MenuItem.changeset(menu_item, menu_item_params)

    case Repo.update(changeset) do
      {:ok, menu_item} ->
        render(conn, "show.json", data: menu_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    menu_item = Repo.get!(MenuItem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(menu_item)

    send_resp(conn, :no_content, "")
  end
end
