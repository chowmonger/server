defmodule Chowmonger.Router do
  use Chowmonger.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :api_auth do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Chowmonger do
    pipe_through :api

    scope "/v1", alias: API.V1 do
      resources "/register", RegistrationController, only: [:create]
      resources "/trucks", TruckController, only: [:index, :show]

      post "/token", TokenController, :create
      get "/address", AddressController, :lookup
    end
  end

  scope "/api", Chowmonger do
    pipe_through :api_auth

    scope "/v1", alias: API.V1 do
      resources "/trucks", TruckController, only: [:update]
      resources "/users", UserController, only: [:show, :update]
      resources "/menu-items", MenuItemController, except: [:new, :edit]

      get "/user", UserController, :current
    end
  end
end
