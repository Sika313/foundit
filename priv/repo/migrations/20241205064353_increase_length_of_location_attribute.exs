defmodule FoundIt.Repo.Migrations.IncreaseLengthOfLocationAttribute do
  use Ecto.Migration

  def change do
    alter table(:lost_or_found) do
     modify :location, :text 
    end
  end
end
