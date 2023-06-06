defmodule CampfireSocialHour.Poller.MeetingsPoller do
  @moduledoc false
  alias CampfireSocialHour.{ZoomApi, Meetings}

  require Logger

  def fetch_and_update() do
    ZoomApi.list_meetings()
    |> handle_response()
  end

  defp handle_response({:ok, %{"meetings" => meetings}}) do
    Logger.debug("SUCCESS updating meetings")

    meetings
    |> Enum.map(fn m -> m["id"] end)
    |> Meetings.update_all_active()
  end

  defp handle_response({:ok, response}) do
    Logger.debug("ERROR MeetingsPoller unrecognized response: #{inspect(response)}")
  end

  defp handle_response({:error, reason}) do
    Logger.debug("ERROR updating meetings: #{inspect(reason)}")
  end
end
