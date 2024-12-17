defmodule FoundIt.Repo.Migrations.AddDeletedField do
  use Ecto.Migration

  def change do
    alter table(:lost_or_found) do
      add :deleted, :boolean, default: false, null: false
    end
  end
end
