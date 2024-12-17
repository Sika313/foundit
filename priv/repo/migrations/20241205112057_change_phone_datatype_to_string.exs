defmodule FoundIt.Repo.Migrations.ChangePhoneDatatypeToString do
  use Ecto.Migration

  def change do
    alter table(:lost_or_found) do
      modify :phone, :string
    end

  end
end
