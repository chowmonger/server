defmodule Chowmonger.API.V1.TrucksTest do
  use Chowmonger.ConnCase
  import Chowmonger.TestHelpers
  import JsonApiAssert
  import JsonApiAssert.Serializer, only: [s: 1]

  setup %{conn: conn} do
    user = insert_user()

    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn, user: user}
  end

  test "GET /api/v1/trucks", %{conn: conn} do
    conn = get conn, "/api/v1/trucks"

    json_response(conn, 200)
    |> assert_jsonapi(version: "1.0")
  end

  test "GET /api/v1/trucks/:id", %{conn: conn, user: user} do
    truck = insert_truck(user, %{name: "Some Truck",
                                 lat: 75.00,
                                 lng: -83.00,
                                 categories: ["street"]})

    conn = get conn, "/api/v1/trucks/#{truck.id}"

    payload = json_response(conn, 200)

    payload
    |> assert_data(s(truck))
    |> assert_jsonapi(version: "1.0")
  end
end
