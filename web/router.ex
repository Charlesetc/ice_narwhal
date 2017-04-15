defmodule IceNarwhal.Router do
  use IceNarwhal.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug IceNarwhal.CurrentUser

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IceNarwhal do
    pipe_through [:browser, :session] # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController, only: [:show, :new, :create]

    resources "/sessions", SessionController, only: [:new, :create, :delete]

  end

  # Other scopes may use custom stacks.
  # scope "/api", IceNarwhal do
  #   pipe_through :api
  # end
end
