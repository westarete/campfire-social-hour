defmodule CampfireSocialHour.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the meeting participant list server
      {CampfireSocialHour.ZoomMeetingParticipants.ParticipantServer, []},
      # Start the meeting status server
      CampfireSocialHour.Meetings.StatusServer,
      # Start the Telemetry supervisor
      CampfireSocialHourWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CampfireSocialHour.PubSub},
      # Start the Endpoint (http/https)
      CampfireSocialHourWeb.Endpoint,
      # Start the recurring job to poll Zoom
      CampfireSocialHour.Poller
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CampfireSocialHour.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CampfireSocialHourWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
