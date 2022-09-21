defmodule KuroCamsWeb.Router do
  use KuroCamsWeb, :router

  import KuroCamsWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KuroCamsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KuroCamsWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  ## Chats Routes

  scope "/", KuroCamsWeb do
    pipe_through [:browser, :require_authenticated_user]

    post "/chats", ChatController, :create
  end

  scope "/", KuroCamsWeb do
    pipe_through [:browser, :require_authenticated_user, :require_chat_authorized_user]

    get "/chats/:uuid", ChatController, :show
    delete "/chats/:uuid", ChatController, :delete
    # Temporal method, must be replaced
    post "/messages/:uuid", MessageController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", KuroCamsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: KuroCamsWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", KuroCamsWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
  end

  scope "/", KuroCamsWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
  end

  scope "/", KuroCamsWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end
