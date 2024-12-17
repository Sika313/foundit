defmodule FoundIt.CategoryTest do
  use FoundIt.DataCase

  alias FoundIt.Category

  describe "category" do
    alias FoundIt.Category.Categories

    import FoundIt.CategoryFixtures

    @invalid_attrs %{name: nil}

    test "list_category/0 returns all category" do
      categories = categories_fixture()
      assert Category.list_category() == [categories]
    end

    test "get_categories!/1 returns the categories with given id" do
      categories = categories_fixture()
      assert Category.get_categories!(categories.id) == categories
    end

    test "create_categories/1 with valid data creates a categories" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Categories{} = categories} = Category.create_categories(valid_attrs)
      assert categories.name == "some name"
    end

    test "create_categories/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Category.create_categories(@invalid_attrs)
    end

    test "update_categories/2 with valid data updates the categories" do
      categories = categories_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Categories{} = categories} = Category.update_categories(categories, update_attrs)
      assert categories.name == "some updated name"
    end

    test "update_categories/2 with invalid data returns error changeset" do
      categories = categories_fixture()
      assert {:error, %Ecto.Changeset{}} = Category.update_categories(categories, @invalid_attrs)
      assert categories == Category.get_categories!(categories.id)
    end

    test "delete_categories/1 deletes the categories" do
      categories = categories_fixture()
      assert {:ok, %Categories{}} = Category.delete_categories(categories)
      assert_raise Ecto.NoResultsError, fn -> Category.get_categories!(categories.id) end
    end

    test "change_categories/1 returns a categories changeset" do
      categories = categories_fixture()
      assert %Ecto.Changeset{} = Category.change_categories(categories)
    end
  end
end
