defmodule CampfireSocialHourWeb.Hooks.MeetingController do
  use CampfireSocialHourWeb, :controller

  alias CampfireSocialHour.{Meetings, ZoomMeetingParticipants, Participants}

  require Logger

  def event(conn, params) do
    handle_event(params)

    conn
    |> send_resp(200, "")
  end

  defp handle_event(%{"event" => "meeting.started", "payload" => payload}) do
    meeting_id = payload["object"]["id"]
    Meetings.set_active(meeting_id)

    Logger.debug("Meeting started: #{meeting_id}")
  end

  defp handle_event(%{"event" => "meeting.ended", "payload" => payload}) do
    meeting_id = payload["object"]["id"]
    Meetings.set_inactive(meeting_id)
    ZoomMeetingParticipants.delete(meeting_id)

    Logger.debug("Meeting ended: #{meeting_id}")
  end

  defp handle_event(%{"event" => "meeting.participant_joined", "payload" => payload}) do
    meeting_id = get_in(payload, ["object", "id"])
    participant = get_in(payload, ["object", "participant"])

    ZoomMeetingParticipants.add_participant(meeting_id, participant)
    Participants.broadcast_update()

    Logger.debug(
      "Participant joined: #{payload["object"]["id"]}, #{payload["object"]["participant"]["user_name"]}"
    )
  end

  defp handle_event(%{"event" => "meeting.participant_left", "payload" => payload}) do
    meeting_id = get_in(payload, ["object", "id"])
    participant = get_in(payload, ["object", "participant"])

    ZoomMeetingParticipants.remove_participant(meeting_id, participant)
    Participants.broadcast_update()

    Logger.debug(
      "Participant left: #{payload["object"]["id"]}, #{payload["object"]["participant"]["user_name"]}"
    )
  end

  defp handle_event(params) do
    Logger.debug("Other event: #{params["event"]}")
  end
end
