defmodule FoundIt.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :fname, :string
    field :lname, :string
    field :password, :string
    field :phone, :string
    field :role, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:fname, :lname, :phone, :password, :role])
    |> validate_required([:fname, :lname, :phone, :password, :role])
  end
end
