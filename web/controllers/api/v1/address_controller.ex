defmodule Chowmonger.API.V1.AddressController do
  use Chowmonger.Web, :controller

  plug :scrub_params, "data" when action in [:create, :update]

  def lookup(conn, %{"data" => %{"attributes" => %{"lat" => lat, "lng" => lng}}}) do
    apiKey = System.get_env("GEOCODE_API_KEY")

    {:ok, %{"results" => results}} =
      HTTPotion.get("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lng}&key=#{apiKey}")
      |> Map.get(:body)
      |> Poison.decode

    {:ok, address} = 
      results
      |> List.first
      |> Map.fetch("formatted_address")

    render(conn, "show.json-api", data: %{address: address})
  end
end
