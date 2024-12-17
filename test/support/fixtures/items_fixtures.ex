defmodule FoundIt.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoundIt.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        category: "some category",
        description: "some description",
        image: "some image",
        location: "some location",
        lost_or_found: "some lost_or_found",
        status: true
      })
      |> FoundIt.Items.create_item()

    item
  end
end
