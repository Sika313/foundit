defmodule FoundIt.Repo.Migrations.CreateLostOrFound do
  use Ecto.Migration

  def change do
    create table(:lost_or_found) do
      add :lost_or_found, :string
      add :category, :string
      add :location, :string
      add :image, :string
      add :description, :string
      add :status, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
