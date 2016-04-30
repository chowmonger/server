defmodule Chowmonger.API.V1.TruckView do
  use Chowmonger.Web, :view

  attributes [:name, :lat, :lng, :image, :categories, :status]

  location "/api/v1/trucks/:id"

  has_many :menu_items,
    serializer: Chowmonger.API.V1.MenuItemView,
    include: true
end
