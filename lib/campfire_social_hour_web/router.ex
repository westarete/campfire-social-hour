defmodule CampfireSocialHourWeb.Router do
  use CampfireSocialHourWeb, :router

  import CampfireSocialHourWeb.Plug.MeetingAuth, only: [fetch_meeting_id: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CampfireSocialHourWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_meeting_id
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :hooks do
    plug :accepts, ["json"]
    plug CampfireSocialHourWeb.Plug.HookAuth
  end

  scope "/", CampfireSocialHourWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/meetings/:meeting_id", CampfireSocialHourWeb do
    pipe_through [:browser, CampfireSocialHourWeb.Plug.MeetingAuth]

    live "/",
         MeetingLive.Index,
         :index

    get "/about", PageController, :about
  end

  scope "/hooks", CampfireSocialHourWeb.Hooks, as: :hooks do
    pipe_through :hooks

    post "/meetings", MeetingController, :event
  end

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
      live_dashboard "/dashboard", metrics: CampfireSocialHourWeb.Telemetry
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
end
