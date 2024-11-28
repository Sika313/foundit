defmodule FoundItWeb.PageController do
  use FoundItWeb, :controller

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
    render(conn, :search)
  end

  def found(conn, _params) do
    render(conn, :found)
  end
end
