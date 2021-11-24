defmodule CampfireSocialHour.ZoomMeetingParticipants.ParticipantServerTest do
  use ExUnit.Case, async: false

  alias CampfireSocialHour.ZoomMeetingParticipants.ParticipantServer

  doctest ParticipantServer

  test "Update one meeting's participants" do
    ParticipantServer.update(1, ["p1", "p2"])

    assert %{"1" => ["p1", "p2"]} = ParticipantServer.get()

    ParticipantServer.update(1, ["p1", "p2", "p3"])

    assert %{"1" => ["p1", "p2", "p3"]} = ParticipantServer.get()
  end

  test "Get full state" do
    ParticipantServer.update(1, ["p1", "p2"])
    ParticipantServer.update(2, ["p3"])

    assert %{"1" => ["p1", "p2"], "2" => ["p3"]} = ParticipantServer.get()
  end

  test "Delete a meeting" do
    ParticipantServer.update(1, ["p1", "p2"])
    ParticipantServer.delete(1)

    state = ParticipantServer.get()
    assert Map.has_key?(state, "1") == false
  end

  test "Add a participant" do
    ParticipantServer.update(1, ["p1"])
    ParticipantServer.add_participant(1, "p2")

    state = ParticipantServer.get()
    assert state["1"] == ["p2", "p1"]
  end

  test "Remove a participant" do
    ParticipantServer.update(1, ["p1", "p2"])
    ParticipantServer.remove_participant(1, "p2")

    state = ParticipantServer.get()
    assert state["1"] == ["p1"]
  end
end
