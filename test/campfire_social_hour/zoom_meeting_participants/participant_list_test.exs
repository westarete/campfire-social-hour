defmodule CampfireSocialHour.ZoomMeetingParticipants.ParticipantListTest do
  use ExUnit.Case, async: true

  alias CampfireSocialHour.ZoomMeetingParticipants.ParticipantList
  import TestFactory

  doctest ParticipantList

  test "new returns a new list" do
    assert ParticipantList.new() == %{}
  end

  test "Update one meeting's participants" do
    list = ParticipantList.new()

    list = ParticipantList.update(list, 1, [participant(1), participant(2)])
    assert Enum.map(list["1"], fn p -> p["user_name"] end) == ~w[p-1 p-2]

    list = ParticipantList.update(list, 1, [participant(1), participant(2), participant(3)])
    assert Enum.map(list["1"], fn p -> p["user_name"] end) == ~w[p-1 p-2 p-3]

    list = ParticipantList.update(list, 2, [participant(4), participant(5)])
    assert Enum.map(list["1"], fn p -> p["user_name"] end) == ~w[p-1 p-2 p-3]
    assert Enum.map(list["2"], fn p -> p["user_name"] end) == ~w[p-4 p-5]

    # String keys work too
    list = ParticipantList.update(list, "2", [participant(6)])
    assert Enum.map(list["1"], fn p -> p["user_name"] end) == ~w[p-1 p-2 p-3]
    assert Enum.map(list["2"], fn p -> p["user_name"] end) == ~w[p-6]
  end

  test "Delete a meeting" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])
      |> ParticipantList.delete(1)

    assert length(Map.keys(list)) == 0

    # String keys also work
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])
      |> ParticipantList.delete("1")

    assert length(Map.keys(list)) == 0
  end

  test "Delete a meeting that doesn't exist" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])
      |> ParticipantList.delete(2)

    assert Map.has_key?(list, "1") == true
  end

  test "Get participants" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])

    assert ParticipantList.get(list, 1) == [participant(1), participant(2)]

    # String keys work too
    assert ParticipantList.get(list, "1") == [participant(1), participant(2)]
  end

  test "Get participants for a meeting that doesn't exist" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])

    assert ParticipantList.get(list, 2) == []
  end

  test "Whitelist meetings deletes all meetings not in the list" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1)])
      |> ParticipantList.update(2, [participant(2)])
      |> ParticipantList.whitelist_meetings([1])

    assert Map.keys(list) == ["1"]
  end

  test "Adding a participant to a list" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])
      |> ParticipantList.add_participant(1, participant(3))

    assert Enum.map(list["1"], fn p -> p["user_name"] end) == ~w[p-3 p-1 p-2]

    # String keys work too
    list = ParticipantList.add_participant(list, "1", participant(4))
    assert Enum.map(list["1"], fn p -> p["user_name"] end) == ~w[p-4 p-3 p-1 p-2]
  end

  test "Adding a participant to a list that doesn't exist" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])
      |> ParticipantList.add_participant(2, participant(3))

    assert list["2"] == [participant(3)]
  end

  test "Adding a participant to a twice does not duplicate it" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])
      |> ParticipantList.add_participant(1, participant(3))
      |> ParticipantList.add_participant(1, participant(3))

    assert Enum.map(list["1"], fn p -> p["user_name"] end) == ~w[p-3 p-1 p-2]
  end

  test "removing a participant that exists" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])

    list = ParticipantList.remove_participant(list, 1, participant(2))
    assert list["1"] == [participant(1)]

    # String keys also work
    list = ParticipantList.remove_participant(list, "1", participant(1))
    assert list["1"] == []
  end

  test "removing a participant that does not exist" do
    list =
      ParticipantList.new()
      |> ParticipantList.update(1, [participant(1), participant(2)])

    # When the meeting_id exists, but the given participant is not a member
    new_list = ParticipantList.remove_participant(list, 1, participant(3))
    assert new_list == list

    # When the meeting_id does not exist
    new_list_2 = ParticipantList.remove_participant(list, 2, participant(1))
    assert new_list_2 == list
  end
end
