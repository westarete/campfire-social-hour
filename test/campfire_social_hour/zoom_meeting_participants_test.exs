defmodule CampfireSocialHour.ZoomMeetingParticipantsTest do
  use ExUnit.Case, async: false

  alias CampfireSocialHour.ZoomMeetingParticipants

  doctest CampfireSocialHour.ZoomMeetingParticipants

  test "Update one meeting's participants" do
    ZoomMeetingParticipants.ParticipantServer.update(1, ["p1", "p2"])

    assert %{"1" => ["p1", "p2"]} = ZoomMeetingParticipants.get()

    ZoomMeetingParticipants.ParticipantServer.update(1, ["p1", "p2", "p3"])

    assert %{"1" => ["p1", "p2", "p3"]} = ZoomMeetingParticipants.get()
  end

  test "Get full state" do
    ZoomMeetingParticipants.ParticipantServer.update(1, ["p1", "p2"])
    ZoomMeetingParticipants.ParticipantServer.update(2, ["p3"])

    assert %{"1" => ["p1", "p2"], "2" => ["p3"]} = ZoomMeetingParticipants.get()
  end

  test "Delete a meeting" do
    ZoomMeetingParticipants.ParticipantServer.update(1, ["p1", "p2"])
    ZoomMeetingParticipants.ParticipantServer.delete(1)

    state = ZoomMeetingParticipants.get()
    refute Map.has_key?(state, "1")
  end

  test "Whitelist meetings" do
    ZoomMeetingParticipants.ParticipantServer.update(1, ["p1", "p2"])
    ZoomMeetingParticipants.ParticipantServer.update(2, ["p3"])
    ZoomMeetingParticipants.whitelist_meetings([1])

    state = ZoomMeetingParticipants.get()
    refute Map.has_key?(state, "2")
  end
end
