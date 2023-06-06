defmodule CampfireSocialHour.ZoomMeetingParticipants.ActiveParticipants do
  @moduledoc false
  def active_participants(participants_response) do
    participants_response
    |> Map.get("participants", [])
    |> Enum.reject(&has_left?/1)
  end

  defp has_left?(participant) do
    Map.has_key?(participant, "leave_time")
  end
end
