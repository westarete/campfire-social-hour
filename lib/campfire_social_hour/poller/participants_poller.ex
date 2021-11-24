defmodule CampfireSocialHour.Poller.ParticipantsPoller do
  alias CampfireSocialHour.{ZoomApi, Meetings, Poller, ZoomMeetingParticipants}
  require Logger

  # This is the public API that should be used by real code
  def fetch_and_update() do
    Meetings.list_meetings()
    |> Stream.map(fn %Meetings.Meeting{id: id} -> id end)
    |> Stream.filter(&Meetings.active?/1)
    |> fetch_and_update_meetings()
  end

  # This is a semi-private helper method that makes testing easier.
  # Please do not use this in "real" code, use fetch_and_update/0
  def fetch_and_update_meetings(active_meeting_ids) do
    active_meeting_ids
    |> Enum.each(&fetch_and_update_participants_for_meeting/1)

    # Delete any participants of inactive meetings, who may potentially be
    # hanging around due to missing a webhook or something
    ZoomMeetingParticipants.whitelist_meetings(active_meeting_ids)

    CampfireSocialHour.Participants.broadcast_update()
  end

  def fetch_and_update_participants_for_meeting(meeting_id) do
    :timer.sleep(Poller.api_delay())

    meeting_id
    |> query_participant_api()
    |> handle_response()
  end

  defp query_participant_api(meeting_id) do
    {
      meeting_id,
      ZoomApi.list_meeting_participants(meeting_id)
    }
  end

  defp handle_response({meeting_id, {:ok, participants}}) do
    Logger.debug("SUCCESS updating #{meeting_id}")
    ZoomMeetingParticipants.update(meeting_id, participants)
  end

  defp handle_response({meeting_id, {:error, {404, _}}}) do
    Logger.debug("ERROR updating #{meeting_id}: 404")
    ZoomMeetingParticipants.delete(meeting_id)
  end

  defp handle_response({meeting_id, {:error, reason}}) do
    Logger.debug("ERROR updating #{meeting_id}: #{inspect(reason)}")
  end
end
