defmodule CampfireSocialHour.Poller.ParticipantsPollerTest do
  use ExUnit.Case, async: true

  alias CampfireSocialHour.{Meetings, ZoomMeetingParticipants, TestFixtures}
  alias CampfireSocialHour.Poller.ParticipantsPoller

  import Tesla.Mock

  describe "when there are no active meetings" do
    test "makes no api calls nor does anything" do
      Meetings.update_all_active([])
      ParticipantsPoller.fetch_and_update()

      # Tesla.Mock would bomb if API calls were made
      assert true
    end
  end

  describe "when there are active meetings, successful api call" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.zoom.us/v2/metrics/meetings/602109/participants"} ->
          %Tesla.Env{status: 200, body: TestFixtures.json("meeting_participants_1.json")}
      end)

      # Meeting_id is just a random number I generated since the ZoomMeetingParticipants
      # server is a singleton and we could potentially collide with another test
      {:ok, meeting_id: "602109"}
    end

    test "updates the participants for that meeting", %{meeting_id: meeting_id} do
      # Clear the meeting_id in question so we can be certain that our code is setting it
      ZoomMeetingParticipants.delete(meeting_id)
      ParticipantsPoller.fetch_and_update_meetings([meeting_id])
      %{^meeting_id => participants} = ZoomMeetingParticipants.get()

      # From api response fixture
      assert Enum.map(participants, fn p -> p["user_name"] end) == ["Chet", "Scott Woods"]
    end

    test "deletes any meeting-participants from inactive meetings", %{meeting_id: meeting_id} do
      # Add a random meeting with a random participant to simulate stale data
      stale_meeting_id = "296780"
      ZoomMeetingParticipants.add_participant(stale_meeting_id, TestFactory.participant(1))
      ParticipantsPoller.fetch_and_update_meetings([meeting_id])
      meeting_participants = ZoomMeetingParticipants.get()

      assert Map.has_key?(meeting_participants, meeting_id)
      refute Map.has_key?(meeting_participants, stale_meeting_id)
    end
  end

  describe "when there are active meetings, 404 api call" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.zoom.us/v2/metrics/meetings/776365/participants"} ->
          json(%{"message" => "does not exist"}, status: 404)
      end)

      {:ok, meeting_id: "776365"}
    end

    test "deletes any existing participants", %{meeting_id: meeting_id} do
      ZoomMeetingParticipants.update(meeting_id, TestFixtures.json("meeting_participants_1.json"))
      ParticipantsPoller.fetch_and_update_meetings([meeting_id])
      participants_state = ZoomMeetingParticipants.get()

      refute Map.has_key?(participants_state, meeting_id)
    end
  end
end
