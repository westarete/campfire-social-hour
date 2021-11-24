defmodule CampfireSocialHour.ZoomMeetingParticipants do
  alias CampfireSocialHour.ZoomMeetingParticipants.{ActiveParticipants, ParticipantServer}

  defdelegate start_link(args), to: ParticipantServer

  defdelegate get(), to: ParticipantServer

  defdelegate whitelist_meetings(meeting_ids), to: ParticipantServer

  defdelegate delete(meeting_id), to: ParticipantServer

  defdelegate add_participant(meeting_id, participant), to: ParticipantServer

  defdelegate remove_participant(meeting_id, participant), to: ParticipantServer

  def update(meeting_id, participants_response) do
    active_participants =
      participants_response
      |> ActiveParticipants.active_participants()

    ParticipantServer.update(meeting_id, active_participants)
  end
end
