defmodule FoundIt.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:category) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
