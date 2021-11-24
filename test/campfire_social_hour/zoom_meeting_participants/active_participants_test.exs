defmodule CampfireSocialHour.ZoomMeetingParticipants.ActiveParticipantsTest do
  use ExUnit.Case

  alias CampfireSocialHour.TestFixtures
  alias CampfireSocialHour.ZoomMeetingParticipants.ActiveParticipants

  test "active participants when nobody has left" do
    participant_names =
      "meeting_participants_1.json"
      |> TestFixtures.json()
      |> ActiveParticipants.active_participants()
      |> Enum.map(fn p -> p["user_name"] end)

    assert ["Chet", "Scott Woods"] == participant_names
  end

  test "active participants when people have left" do
    participant_names =
      "meeting_participants_3.json"
      |> TestFixtures.json()
      |> ActiveParticipants.active_participants()
      |> Enum.map(fn p -> p["user_name"] end)

    assert ["Chet", "Scott Woods"] == participant_names
  end
end
