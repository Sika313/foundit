defmodule FoundItWeb.PageController do
  use FoundItWeb, :controller

  alias FoundIt.AddItem
  alias FoundIt.EditItem
  alias FoundIt.Items

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def login(conn, _params) do
    render(conn, :login)
  end

  def signup(conn, _params) do
    render(conn, :signup)
  end

  def search(conn, _params) do
    render(conn, :search)
  end
  
  def handle_search(conn, params) do
    IO.inspect(params, label: "SEARCH PARAMS--->")
    new_params = %{category: params["category"]}
    IO.inspect(new_params, label: "NEW PARAMS--->")
    case Items.search_by_category(new_params) do
      {:ok, result} ->
        render(conn, :search)
      {:error} -> conn
        |> put_flash(:error, "NO ITEM FOUND IN THIS CATEGORY.")
        |> render(:search)
    end
  end

  def found(conn, _params) do
    render(conn, :found)
  end

  def handle_found(conn, params) do
    IO.inspect(params, label: "FOUND PARAMS--->")
    case AddItem.add_found(params) do
      {:ok, token} -> 
      msg = "Found item added successfully. Use this token to make changes to the item:" <> Integer.to_string(token)
      conn
      |> put_flash(:info, msg)
      |> render(:found)
      {:error} -> render(conn, :home)
    end
  end

  def edit_item(conn, _params) do
    render(conn, :edit)
  end

  def handle_edit_item(conn, params) do
    case EditItem.retrieve_item(params["token"]) do
      {:ok, result} ->
        r = Map.from_struct(result)
        
        conn
        |> put_flash(:info, "Item found.")
        |> assign( :item, r)
        |> assign( :img_path, "/images/found/" <> r.image)
        |> IO.inspect(label: "CONN--->")
        |> render(:edit_item_result)
      {:not_found} ->
        conn
        |> put_flash(:error, "ITEM NOT FOUND, CONTACT 0779567086 FOR HELP.")
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
         r = Map.from_struct(result)
        conn
        |> put_flash(:info, "Item updated.")
        |> assign( :item, r)
        |> assign( :img_path, "/images/found/" <> r.image)
        |> IO.inspect(label: "CONN--->")
        |> render(:edit_item_result)

      {:error, _} ->
        conn
        |> put_flash(:error, "Ooops, something went wrong. Contact 0779567086 for help.")
        |> render(:edit_item_result)

    end
  end

end
