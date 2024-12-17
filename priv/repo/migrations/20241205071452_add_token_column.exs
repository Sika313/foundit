defmodule FoundIt.Repo.Migrations.AddTokenColumn do
  use Ecto.Migration

  def change do
    alter table(:lost_or_found) do
      add :token, :integer
    end
  end
end
