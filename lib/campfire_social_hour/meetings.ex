defmodule CampfireSocialHour.Meetings do
  @moduledoc false
  alias CampfireSocialHour.Meetings.{Hardcoded, MeetingParticipantJoiner, StatusServer}

  defdelegate list_meetings(), to: Hardcoded

  def list_meetings_with_participants(participants_map) do
    list_meetings()
    |> MeetingParticipantJoiner.join(participants_map)
  end

  defdelegate active?(meeting_id), to: StatusServer
  defdelegate set_active(meeting_id), to: StatusServer
  defdelegate set_inactive(meeting_id), to: StatusServer
  defdelegate update_all_active(meeting_id_list), to: StatusServer
end
