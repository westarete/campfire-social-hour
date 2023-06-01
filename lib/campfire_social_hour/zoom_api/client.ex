defmodule CampfireSocialHour.ZoomApi.Client do
  @moduledoc """
  Custom Zoom API client for use with the rest of the application
  """

  def new(token) do
    [
      {Tesla.Middleware.BaseUrl, "https://api.zoom.us/v2"},
      {Tesla.Middleware.BearerAuth, token: token},
      Tesla.Middleware.JSON
    ]
    |> Tesla.client()
  end

  def user_details(client, user_id) do
    Tesla.get(client, "users/#{user_id}")
    |> handle_response()
  end

  def list_meetings(client) do
    Tesla.get(client, "/metrics/meetings")
    |> handle_response()
  end

  def list_meeting_participants(client, meeting_id) do
    Tesla.get(client, "/metrics/meetings/#{meeting_id}/participants")
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}),
    do: {:ok, body}

  defp handle_response({:ok, %Tesla.Env{status: status, body: body}}),
    do: {:error, {status, body}}

  defp handle_response({_, response}),
    do: {:error, response}
end
