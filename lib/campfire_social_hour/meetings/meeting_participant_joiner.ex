defmodule CampfireSocialHour.Meetings.MeetingParticipantJoiner do
  import CampfireSocialHour.Meetings.Meeting, only: [canonize_id: 1]

  # Accepts a list of meetings, and a map of %{meeting_id => [participants]}
  # and returns a list of meetings with their respective participants
  #
  # Any meetings that do not have an entry in the meetings_participants map
  # will have [] for their participants.
  def join(meetings, meetings_participants) do
    meetings
    |> Enum.map(&join_a_meeting(&1, meetings_participants))
  end

  defp join_a_meeting(meeting, meetings_participants) do
    participants = Map.get(meetings_participants, canonize_id(meeting.id), [])

    meeting
    |> Map.from_struct()
    |> Map.put(:participants, participants)
  end
end
