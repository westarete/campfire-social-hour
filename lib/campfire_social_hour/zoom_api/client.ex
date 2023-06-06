defmodule CampfireSocialHour.ZoomApi.Client do
  @moduledoc false
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.zoom.us/v2")
  plug(Tesla.Middleware.BearerAuth, token: Application.fetch_env!(:campfire_social_hour, :jwt))
  plug(Tesla.Middleware.JSON)

  def user_details(user_id) do
    get("users/#{user_id}")
    |> handle_response()
  end

  def list_meetings() do
    get("/metrics/meetings")
    |> handle_response()
  end

  def list_meeting_participants(meeting_id) do
    get("/metrics/meetings/#{meeting_id}/participants")
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}),
    do: {:ok, body}

  defp handle_response({:ok, %Tesla.Env{status: status, body: body}}),
    do: {:error, {status, body}}

  defp handle_response({_, response}),
    do: {:error, response}
end
