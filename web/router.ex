defmodule Derviche.Router do
  use Derviche.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    get "/highscores", PlayerController, :highscores
    post "/score", PlayerController, :score
    
    resources "/players", PlayerController, except: [:new, :edit]
  end

  scope "/", Derviche do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Derviche do
  #   pipe_through :api
  # end
end
