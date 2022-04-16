defmodule CampfireSocialHourWeb.Plug.MeetingAuth do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    allowed_meeting_id = Application.fetch_env!(:campfire_social_hour, :meeting_secret)
    %{"meeting_id" => meeting_id} = conn.params

    authorize(conn, meeting_id == allowed_meeting_id)
  end

  def fetch_meeting_id(conn, _opts) do
    meeting_id = Map.get(conn.params, "meeting_id", nil)

    conn
    |> assign(:meeting_id, meeting_id)
  end

  defp authorize(conn, _allowed = true), do: conn

  defp authorize(conn, _not_allowed) do
    conn
    |> Phoenix.Controller.render(CampfireSocialHourWeb.ErrorView, :"404")
    |> halt()
  end
end
