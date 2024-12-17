defmodule FoundIt.Repo.Migrations.AddContactColumn do
  use Ecto.Migration

  def change do
    alter table(:lost_or_found) do
      add :phone, :integer
    end

  end
end
