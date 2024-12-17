defmodule FoundItWeb.Router do
  use FoundItWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FoundItWeb.Layouts, :root}
#    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoundItWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/login", PageController, :login
    post "/handle_login", PageController, :handle_login
    get "/signup", PageController, :signup
    get "/edit_item", PageController, :edit_item
    post "/edit_item", PageController, :handle_edit_item
    post "/update_item_info", PageController, :update_item_info
    get "/search_item", PageController, :search
    post "/search_item", PageController, :handle_search
    get "/found_item", PageController, :found
    post "/add_found_item", PageController, :handle_found

    get "/admin/view_all", PageController, :view_all
    get "/admin/view_claimed", PageController, :view_claimed
    get "/admin/view_not_claimed", PageController, :view_not_claimed
    get "/admin/view_categories", PageController, :view_categories
    get "/admin/add_category", PageController, :add_category
    post "/admin/add_category", PageController, :handle_add_category
    get "/admin/add_user", PageController, :add_user
    post "/admin/add_user", PageController, :handle_add_user

  end

  # Other scopes may use custom stacks.
  # scope "/api", FoundItWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:found_it, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FoundItWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
