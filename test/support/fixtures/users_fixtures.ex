defmodule FoundIt.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoundIt.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        fname: "some fname",
        lname: "some lname",
        password: "some password",
        phone: "some phone",
        role: "some role"
      })
      |> FoundIt.Users.create_user()

    user
  end
end
