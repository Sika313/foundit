defmodule FoundItWeb.PageController do
  use FoundItWeb, :controller

  alias FoundIt.AddItem
  alias FoundIt.EditItem
  alias FoundIt.Items
  alias FoundIt.Users
  alias FoundIt.Items.Item
  alias FoundIt.Items
  alias FoundIt.Category
  alias FoundIt.Roles

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def login(conn, _params) do
    render(conn, :login)
  end

  def handle_login(conn, params) do
    case Users.get_user_by_phone_and_password(params) do
      {:ok, result} ->
        user =  Map.from_struct(result) |> IO.inspect() |>  Map.delete(:__meta__) 
        to_render = case user.role do
          "ADMIN" -> :admin
          "DATA ENTRY" -> :data_entry
        end
        total_items = Items.list_lost_or_found() |> Enum.count()
        total_items_claimed = Items.found_items_claimed() |> Enum.count()
        total_items_not_claimed = Items.found_items_not_claimed() |> Enum.count()
        total_data_entry = Users.get_data_entry() |> Enum.count()

    categories = Category.list_category() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta__) end )
        conn
        |> assign(:user, user)
        |> assign(:categories, categories)
        |> assign(:total_data_entry, total_data_entry)
        |> assign(:total_items, total_items)
        |> assign(:total_items_claimed, total_items_claimed)
        |> assign(:total_items_not_claimed, total_items_not_claimed)
        |> render(to_render)
      {:not_found} ->
        conn
        |> put_flash(:error, "INVALID CREDENTIALS.")
        |> render(:login)
    end
  end


  def about_us(conn, _params) do
    render(conn, :about_us)
  end

  def view_users(conn, _params) do
    users = Users.list_users()
    |> Enum.map(fn i -> Map.from_struct(i) end)
    |> Enum.map(fn i -> Map.delete(i, :__meta__) end)
    IO.inspect(users)
    conn
    |> assign(:users, users)
    |> render(:admin_view_users)
  end

  def view_all(conn, _params) do
    view_all = Items.list_lost_or_found() 
    conn
    |> assign(:view_all, view_all)
    |> render(:admin_view_all)
  end

  def view_claimed(conn, _params) do
    view_claimed = Items.found_items_claimed() 
    conn
    |> assign(:view_claimed, view_claimed)
    |> render(:admin_view_claimed)
  end

  def view_not_claimed(conn, _params) do
    view_not_claimed = Items.found_items_not_claimed() 
    conn
    |> assign(:view_not_claimed, view_not_claimed)
    |> render(:admin_view_not_claimed)
  end

  def view_categories(conn, _params) do

    categories = Category.list_category() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta__) end )
    conn
    |> assign(:categories, categories)
    |> render(:view_categories)
  end

  def add_category(conn, _params) do
    render(conn, :add_category)
  end
  
  def handle_add_category(conn, params) do
    IO.inspect(params, label: "CATEGORY--->")
   Category.create_categories(params)
   conn
   |> put_flash(:info, "Category successfully added.")
   |> render(:add_category)  
  end

  def signup(conn, _params) do
    render(conn, :signup)
  end

  def search(conn, _params) do
    categories = Category.list_category() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta__) end )
    conn
    |> assign(:categories, categories)
    |> render(:search)
  end
  
  def handle_search(conn, params) do
    new_params = %{category: params["category"]}
    case Items.search_by_category(new_params) do
      {:ok, results} ->
        IO.inspect(results, label: "RESULT--->")
        r = Enum.map(results, fn i -> Map.from_struct(i) |> Map.delete(:__meta__) end )
        conn
        |> assign(:items, r)
        |> render(:list_category)
      {:error} -> conn
        |> put_flash(:error, "NO ITEM FOUND IN THIS CATEGORY.")
        |> render(:search)
    end
  end

  def found(conn, _params) do
    categories = Category.list_category() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta__) end )
    conn
    |> assign(:categories, categories)
    |> render(:found)

  end

  def handle_found(conn, params) do
    case AddItem.add_found(params) do
      {:ok, token} -> 
      msg = "Found item added successfully. Use this token to make changes to the item:" <> Integer.to_string(token)
      conn
      |> put_flash(:info, msg)
      |> render(:home)
      {:error} -> render(conn, :home)
    end
  end

  def edit_item(conn, _params) do

    categories = Category.list_category() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta__) end )
    conn
    |> assign(:categories, categories)
    |> render(:edit)
  end

  def handle_edit_item(conn, params) do
    IO.inspect("HIT--->")
    case EditItem.retrieve_item(params["token"]) do
      {:ok, result} ->
        r = Map.from_struct(result)
        
    categories = Category.list_category() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta__) end )
        conn
        |> put_flash(:info, "Item found.")
        |> assign( :item, r)
        |> assign(:categories, categories)
        |> assign( :img_path, "/images/found/" <> r.image)
        |> IO.inspect(label: "CONN--->")
        |> render(:edit_item_result)
      {:not_found} ->
        conn
        |> put_flash(:error, "ITEM NOT FOUND, CONTACT 0975749165 FOR HELP.")
        |> render(:edit)
    end
  end

  def update_item_info(conn, params) do
    category = if params["category"] == params["category_old"] do "" else params["category"] end
    status = if params["status"] == "yes" do true else false end
    receiver_phone = if params["receiver_phone"] == "" do "" else params["receiver_phone"] end
    n = %{
      "category" => category,
      "description" => params["description"],
      "image" => params["image"],
      "location" => params["location"],
      "phone" => params["phone"],
      "token" => params["token"],
      "status" => status,
      "receiver_phone" => receiver_phone
    }
    new_params = Enum.filter(n, fn {x, y} -> y != "" end) |> Map.new() 
    {:ok, result} = EditItem.retrieve_item(params["token"]) 
    case Items.update_item(result, new_params) do 
      {:ok, _} ->

        {:ok, result} = EditItem.retrieve_item(params["token"]) 

    categories = Category.list_category() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta__) end )
         r = Map.from_struct(result)
        conn
        |> put_flash(:info, "Item updated.")
        |> assign( :item, r)
        |> assign(:categories, categories)
        |> assign( :img_path, "/images/found/" <> r.image)
        |> IO.inspect(label: "CONN--->")
        |> render(:edit_item_result)

      {:error, _} ->
        conn
        |> put_flash(:error, "Ooops, something went wrong. Contact 0779567086 for help.")
        |> render(:edit_item_result)

    end
  end

  def add_user(conn, _params) do
    roles = Roles.list_roles() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta) end)
    conn
    |> assign(:roles, roles)
    |> render(:add_user)
  end
  
  def handle_add_user(conn, params) do
    Users.create_user(params) 
    roles = Roles.list_roles() |> Enum.map(fn i -> Map.from_struct(i) end) |> Enum.map(fn i -> Map.delete(i, :__meta) end)
    conn
    |> assign(:roles, roles)
    |> put_flash(:info, "User added successfully.")
    |> render(:add_user)

  end

end
