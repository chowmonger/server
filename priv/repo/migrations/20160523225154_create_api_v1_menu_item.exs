defmodule Chowmonger.Repo.Migrations.CreateAPI.V1.MenuItem do
  use Ecto.Migration

  def change do
    create table(:menu_item) do
      add :name, :string
      add :description, :text
      add :price, :float
      add :truck_id, references(:trucks, on_delete: :nothing)

      timestamps
    end
    create index(:menu_item, [:truck_id])

  end
end
