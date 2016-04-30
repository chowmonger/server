defmodule Chowmonger.API.V1.MenuItemView do
  use Chowmonger.Web, :view

  location "/api/v1/menu-items/:id"

  attributes [:name, :description, :price]
end
