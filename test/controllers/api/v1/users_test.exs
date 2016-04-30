defmodule Chowmonger.API.V1.UsersTest do
  use Chowmonger.ConnCase
  import Chowmonger.TestHelpers
  import JsonApiAssert
  import JsonApiAssert.Serializer, only: [s: 1]

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
end
