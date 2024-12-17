defmodule FoundIt.Items do
  @moduledoc """
  The Items context.
  """

  import Ecto.Query, warn: false
  alias FoundIt.Repo

  alias FoundIt.Items.Item

  def search_by_category(category) do
    IO.inspect(category, label: "CATEGORY--->")
    query = from p in Item, where: p.category == ^category.category and p.status == false 
    case Repo.all(query) do
      results -> 
        {:ok, results}
      [] -> {:error}
    end
  end

  def structs_to_maps(result) do
    r = 
    result
    |> Enum.map( fn i -> Map.from_struct(i) end )
    |> IO.inspect(label: "TEST--->")
    |> Map.pop(:__meta__)
    r
  end

  def lost_items do
    query = from i in Item, where: i.lost_or_found == "lost"
    Repo.all(query)
  end

  def found_items() do
    query = from i in Item, where: i.lost_or_found == "found" 
    Repo.all(query)
  end

  def found_items_claimed() do
    query = from i in Item, where: i.status == true 
    Repo.all(query)
  end

  def found_items_not_claimed() do
    query = from i in Item, where: i.status == false 
    Repo.all(query)
  end

  @doc """
  Returns the list of lost_or_found.

  ## Examples

      iex> list_lost_or_found()
      [%Item{}, ...]

  """
  def list_lost_or_found do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end
end
