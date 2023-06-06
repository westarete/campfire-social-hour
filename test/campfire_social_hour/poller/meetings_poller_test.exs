defmodule CampfireSocialHour.Poller.MeetingsPollerTest do
  use CampfireSocialHour.ZoomApiCase, async: false

  alias CampfireSocialHour.{Meetings, TestFixtures}
  alias CampfireSocialHour.Poller.MeetingsPoller

  import Tesla.Mock

  describe "successful api call" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.zoom.us/v2/metrics/meetings"} ->
          %Tesla.Env{status: 200, body: TestFixtures.json("meetings.json")}
      end)
    end

    test "updates Meetings state with results of api call" do
      Meetings.update_all_active([])
      MeetingsPoller.fetch_and_update()

      # Ids from mock json response
      assert Meetings.active?("1111111")
      assert Meetings.active?("2222222")
    end
  end

  describe "error api call" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.zoom.us/v2/metrics/meetings"} ->
          json(%{"some" => "data"}, status: 404)
      end)
    end

    test "does nothing" do
      meetings_before = :sys.get_state(Meetings.StatusServer)
      MeetingsPoller.fetch_and_update()
      meetings_after = :sys.get_state(Meetings.StatusServer)

      assert meetings_before == meetings_after
    end
  end

  describe "successful api call, but with bogus data" do
    setup do
      mock(fn
        %{method: :get, url: "https://api.zoom.us/v2/metrics/meetings"} ->
          json(%{"bogus" => "data"})
      end)
    end

    test "does nothing" do
      meetings_before = :sys.get_state(Meetings.StatusServer)
      MeetingsPoller.fetch_and_update()
      meetings_after = :sys.get_state(Meetings.StatusServer)

      assert meetings_before == meetings_after
    end
  end
end
