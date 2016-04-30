defmodule Chowmonger.API.V1.TruckTest do
  use Chowmonger.ModelCase

  alias Chowmonger.API.V1.Truck

  @valid_attrs [
    %{name: "Some Truck", lat: 75.00, lng: -83.00, categories: ["chinese"]},
    %{name: "Some Truck", lat: 75.00, lng: -83, categories: ["chinese"]},
    %{name: "S", lat: 75.00, lng: -83, categories: ["chinese"]}
  ]

  @invalid_attrs [
    %{name: "", lat: 75.00, lng: -83, categories: ["chinese"]},
    %{name: "Some Truck", lng: -83.00, categories: ["chinese"]},
    %{name: "Some Truck", lat: 75.00, categories: ["chinese"]},
    %{name: "Some Truck", lat: 75.00, lng: -83.00},
    %{name: "Some Truck", lat: 75.00, lng: -83.00, categories: [:blagh]},
    %{lat: 75.00, lng: -83.00, categories: ["chinese"]},
    %{}
  ]

  test "changeset with valid attributes" do
    Enum.each @valid_attrs, fn(attrs) ->
      changeset = Truck.changeset(%Truck{}, attrs)
      assert changeset.valid?
    end
  end

  test "changeset with invalid attributes" do
    Enum.each @invalid_attrs, fn(attrs) ->
      changeset = Truck.changeset(%Truck{}, attrs)
      refute changeset.valid?
    end
  end
end
