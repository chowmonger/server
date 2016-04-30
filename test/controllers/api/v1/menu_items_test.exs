defmodule Chowmonger.API.V1.MenuItemsTest do
  use Chowmonger.ConnCase

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
end
