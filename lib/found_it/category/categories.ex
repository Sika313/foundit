defmodule FoundIt.Category.Categories do
  use Ecto.Schema
  import Ecto.Changeset

  schema "category" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(categories, attrs) do
    categories
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
