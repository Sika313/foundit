defmodule FoundIt.Repo.Migrations.AddItemReceiverContact do
  use Ecto.Migration

  def change do
    alter table(:lost_or_found) do
      add :receiver_phone, :string
    end
  end
end
