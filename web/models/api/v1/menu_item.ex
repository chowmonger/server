defmodule Chowmonger.API.V1.MenuItem do
  use Chowmonger.Web, :model

  schema "menu_item" do
    field :name, :string
    field :description, :string
    field :price, :float
    belongs_to :truck, Chowmonger.Truck

    timestamps
  end

  @required_fields ~w(name description price)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
