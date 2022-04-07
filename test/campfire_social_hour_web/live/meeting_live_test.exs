defmodule CampfireSocialHourWeb.MeetingLiveTest do
  use CampfireSocialHourWeb.ConnCase

  import Phoenix.LiveViewTest
  import Phoenix.HTML, only: [html_escape: 1, safe_to_string: 1]

  alias CampfireSocialHour.{Meetings, ZoomMeetingParticipants, Participants}

  # The list of meetings is hardcoded, no fixtures/db records to create
  # but we do need to prep the genservers a bit
  defp create_meetings(_) do
    [first_meeting | _] = meetings = Meetings.list_meetings()

    participant = TestFactory.participant(123)

    ZoomMeetingParticipants.add_participant(first_meeting.id, participant)

    %{meetings: meetings, participant: participant}
  end

  # Erase all existing meeting-participants
  defp clean_state(_) do
    ZoomMeetingParticipants.whitelist_meetings([])
    :ok
  end

  defp escape(str) do
    str
    |> html_escape()
    |> safe_to_string()
  end

  defp meeting_index_path(conn) do
    Routes.meeting_index_path(
      conn,
      :index,
      Application.fetch_env!(:campfire_social_hour, :meeting_secret)
    )
  end

  describe "Index" do
    setup [:clean_state, :create_meetings]

    test "lists all meetings", %{conn: conn, meetings: meetings, participant: participant} do
      {:ok, _index_live, html} = live(conn, meeting_index_path(conn))

      for %Meetings.Meeting{topic: t} <- meetings do
        assert html =~ escape(t)
      end

      assert html =~ escape(participant["user_name"])
    end

    test "adds new participants", %{conn: conn, meetings: [meeting | _]} do
      {:ok, index_live, _html} = live(conn, meeting_index_path(conn))

      # Create a new participant, add it to the MeetingParticipants list, and broadcast to view
      new_participant = TestFactory.participant(456)
      ZoomMeetingParticipants.add_participant(meeting.id, new_participant)
      Participants.broadcast_update()

      assert render(index_live) =~ escape(new_participant["user_name"])
    end
  end
end
