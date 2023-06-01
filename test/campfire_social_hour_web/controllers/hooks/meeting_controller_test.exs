defmodule CampfireSocialHourWeb.Hooks.MeetingControllerTest do
  use CampfireSocialHourWeb.ConnCase

  alias CampfireSocialHour.{Meetings, ZoomMeetingParticipants, TestFixtures}

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("content-type", "application/json")

    {:ok, conn: conn}
  end

  describe "meeting.started" do
    setup context do
      req_body = TestFixtures.file("hook_meeting_started.json")
      meeting_id = get_in(Jason.decode!(req_body), ["payload", "object", "id"])

      {:ok, Map.merge(context, %{req_body: req_body, meeting_id: meeting_id})}
    end

    test "sets the meeting as active", %{conn: conn, req_body: req_body, meeting_id: meeting_id} do
      Meetings.set_inactive(meeting_id)

      conn =
        conn
        |> set_zoom_headers(req_body)
        |> post(Routes.hooks_meeting_path(conn, :event), req_body)

      assert response(conn, 200)
      assert Meetings.active?(meeting_id)
    end
  end

  describe "meeting.started when not authorized" do
    test "lists all participants", %{conn: conn} do
      conn = post(conn, Routes.hooks_meeting_path(conn, :event))

      assert response(conn, 401)
    end
  end

  describe "meeting.ended" do
    setup context do
      req_body = TestFixtures.file("hook_meeting_ended.json")
      meeting_id = get_in(Jason.decode!(req_body), ["payload", "object", "id"])

      {:ok, Map.merge(context, %{req_body: req_body, meeting_id: meeting_id})}
    end

    test "sets the meeting as inactive and erases any participants", %{
      conn: conn,
      req_body: req_body,
      meeting_id: meeting_id
    } do
      Meetings.set_active(meeting_id)
      ZoomMeetingParticipants.add_participant(meeting_id, TestFactory.participant(1))

      conn =
        conn
        |> set_zoom_headers(req_body)
        |> post(Routes.hooks_meeting_path(conn, :event), req_body)

      assert response(conn, 200)
      refute Meetings.active?(meeting_id)
      refute Map.has_key?(ZoomMeetingParticipants.get(), meeting_id)
    end
  end

  describe "meeting.participant_joined" do
    setup context do
      req_body = TestFixtures.file("hook_meeting_participant_joined.json")
      meeting_id = get_in(Jason.decode!(req_body), ["payload", "object", "id"])
      participant = get_in(Jason.decode!(req_body), ["payload", "object", "participant"])

      {:ok,
       Map.merge(context, %{req_body: req_body, meeting_id: meeting_id, participant: participant})}
    end

    test "adds the participant to the meeting", %{
      conn: conn,
      req_body: req_body,
      meeting_id: meeting_id,
      participant: participant
    } do
      Meetings.set_active(meeting_id)
      ZoomMeetingParticipants.delete(meeting_id)

      conn =
        conn
        |> set_zoom_headers(req_body)
        |> post(Routes.hooks_meeting_path(conn, :event), req_body)

      assert response(conn, 200)
      assert %{^meeting_id => [^participant]} = ZoomMeetingParticipants.get()
    end
  end

  describe "meeting.participant_left" do
    setup context do
      req_body = TestFixtures.file("hook_meeting_participant_left.json")
      meeting_id = get_in(Jason.decode!(req_body), ["payload", "object", "id"])
      participant = get_in(Jason.decode!(req_body), ["payload", "object", "participant"])

      {:ok,
       Map.merge(context, %{req_body: req_body, meeting_id: meeting_id, participant: participant})}
    end

    test "Removes the participant from the meeting", %{
      conn: conn,
      req_body: req_body,
      meeting_id: meeting_id,
      participant: participant
    } do
      Meetings.set_active(meeting_id)
      ZoomMeetingParticipants.add_participant(meeting_id, participant)

      conn =
        conn
        |> set_zoom_headers(req_body)
        |> post(Routes.hooks_meeting_path(conn, :event), req_body)

      assert response(conn, 200)
      assert %{^meeting_id => []} = ZoomMeetingParticipants.get()
    end
  end

  defp set_zoom_headers(conn, payload) do
    timestamp = :os.system_time(:seconds) |> to_string()

    signature =
      :crypto.mac(
        :hmac,
        :sha256,
        Application.fetch_env!(:campfire_social_hour, :secret_token),
        "v0:#{timestamp}:#{payload}"
      )
      |> Base.encode16(case: :lower)

    conn
    |> put_req_header("x-zm-signature", "v0=#{signature}")
    |> put_req_header("x-zm-request-timestamp", timestamp)
  end
end
