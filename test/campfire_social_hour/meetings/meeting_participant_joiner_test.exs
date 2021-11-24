defmodule CampfireSocialHour.Meetings.MeetingParticipantJoinerTest do
  use ExUnit.Case, async: true
  alias CampfireSocialHour.Meetings.{Meeting, MeetingParticipantJoiner}

  setup do
    meetings = [
      %Meeting{id: 1, topic: "t1", link: "l1"},
      %Meeting{id: 2, topic: "t2", link: "l2"}
    ]

    %{meetings: meetings}
  end

  test "joins meetings with their participants", %{meetings: meetings} do
    participants = %{
      "1" => ["p1"],
      "2" => ["p2"]
    }

    assert [
             %{id: 1, topic: "t1", link: "l1", participants: ["p1"]},
             %{id: 2, topic: "t2", link: "l2", participants: ["p2"]}
           ] ==
             MeetingParticipantJoiner.join(meetings, participants)
  end

  test "inserts an empty array if no participants are found", %{meetings: meetings} do
    participants = %{
      "1" => ["p1"]
    }

    assert [
             %{id: 1, topic: "t1", link: "l1", participants: ["p1"]},
             %{id: 2, topic: "t2", link: "l2", participants: []}
           ] ==
             MeetingParticipantJoiner.join(meetings, participants)
  end
end
