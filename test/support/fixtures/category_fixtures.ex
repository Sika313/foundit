defmodule FoundIt.CategoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoundIt.Category` context.
  """

  @doc """
  Generate a categories.
  """
  def categories_fixture(attrs \\ %{}) do
    {:ok, categories} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> FoundIt.Category.create_categories()

    categories
  end
end
