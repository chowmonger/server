defmodule Chowmonger.TestHelpers do
  alias Chowmonger.{Repo, API.V1.User}

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Generated User",
      email: "user#{Base.encode16(:crypto.rand_bytes(8))}@example.com",
      password: "password",
    }, attrs)

    %User{}
    |> User.changeset(changes)
    |> Repo.insert!()
  end

  def insert_truck(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:truck, attrs)
    |> Repo.insert!()
  end
end
