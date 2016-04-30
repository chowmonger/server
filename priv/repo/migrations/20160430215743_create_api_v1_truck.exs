defmodule Chowmonger.Repo.Migrations.CreateAPI.V1.Truck do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :name, :string, null: false
      add :lat, :float, null: false
      add :lng, :float, null: false
      add :image, :string, default: "https://upload.wikimedia.org/wikipedia/commons/e/e3/Food_truck_in_London.jpg"
      add :menu, {:array, :string}
      add :status, :boolean, default: false
      add :categories, {:array, :string}
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:trucks, [:user_id])

  end
end
