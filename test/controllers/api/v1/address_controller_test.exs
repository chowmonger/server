defmodule Chowmonger.API.V1.AddressControllerTest do
  use Chowmonger.ConnCase
  import Chowmonger.TestHelpers
  import JsonApiAssert
  import JsonApiAssert.Serializer, only: [s: 1]

  @valid_attr %{"data" => %{"attributes" => %{lat: 73, lng: -82}}}

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  test "GET /api/v1/address", %{conn: conn} do
    conn = get conn, "/api/v1/address", @valid_attr

    json_response(conn, 200)
    |> assert_jsonapi(version: "1.0")
    |> assert_address
  end

  defp assert_address(data) do
    get_in(data, ["data", "attributes", "address"])
    |> String.length
    |> assert > 0
  end
end
