defmodule FoundIt.ItemsTest do
  use FoundIt.DataCase

  alias FoundIt.Items

  describe "lost_or_found" do
    alias FoundIt.Items.Item

    import FoundIt.ItemsFixtures

    @invalid_attrs %{category: nil, description: nil, image: nil, location: nil, lost_or_found: nil, status: nil}

    test "list_lost_or_found/0 returns all lost_or_found" do
      item = item_fixture()
      assert Items.list_lost_or_found() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{category: "some category", description: "some description", image: "some image", location: "some location", lost_or_found: "some lost_or_found", status: true}

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.category == "some category"
      assert item.description == "some description"
      assert item.image == "some image"
      assert item.location == "some location"
      assert item.lost_or_found == "some lost_or_found"
      assert item.status == true
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{category: "some updated category", description: "some updated description", image: "some updated image", location: "some updated location", lost_or_found: "some updated lost_or_found", status: false}

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.category == "some updated category"
      assert item.description == "some updated description"
      assert item.image == "some updated image"
      assert item.location == "some updated location"
      assert item.lost_or_found == "some updated lost_or_found"
      assert item.status == false
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
