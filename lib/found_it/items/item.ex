defmodule FoundIt.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lost_or_found" do
    field :category, :string
    field :description, :string
    field :image, :string
    field :location, :string
    field :lost_or_found, :string
    field :status, :boolean, default: false
    field :phone, :string
    field :token, :integer
    field :receiver_phone, :string
    field :deleted, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:lost_or_found, :category, :location, :image, :description, :status, :phone, :token, :receiver_phone, :deleted])
    |> validate_required([:lost_or_found, :category, :location, :image, :description, :status, :phone, :token])
  end
end
