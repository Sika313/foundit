defmodule FoundIt.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :fname, :string
      add :lname, :string
      add :phone, :string
      add :password, :string
      add :role, :string

      timestamps(type: :utc_datetime)
    end
  end
end
