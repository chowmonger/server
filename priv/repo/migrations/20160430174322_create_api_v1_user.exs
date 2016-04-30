defmodule Chowmonger.Repo.Migrations.CreateAPI.V1.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password, :string, virtual: true
      add :password_hash, :string, null: false

      timestamps
    end

    create unique_index(:users, [:email])
  end
end
