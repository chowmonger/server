defmodule Chowmonger.API.V1.UserView do
  use Chowmonger.Web, :view

  attributes [:name, :email]

  location "/api/v1/user"

  has_one :truck,
    serializer: Chowmonger.API.V1.TruckView,
    links: [related: "/api/v1/trucks/:id"],
    include: false
end
