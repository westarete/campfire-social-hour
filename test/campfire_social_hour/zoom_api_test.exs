defmodule CampfireSocialHour.ZoomApiTest do
  use ExUnit.Case

  alias CampfireSocialHour.{ZoomApi, TestFixtures}

  doctest ZoomApi

  import Tesla.Mock

  setup do
    mock(fn
      %{method: :get, url: "https://api.zoom.us/v2/users/user-123"} ->
        %Tesla.Env{status: 200, body: TestFixtures.json("user.json")}

      %{method: :get, url: "https://api.zoom.us/v2/users/does-not-exist"} ->
        %Tesla.Env{status: 404, body: TestFixtures.json("user_404.json")}

      %{method: :get, url: "https://api.zoom.us/v2/metrics/meetings"} ->
        %Tesla.Env{status: 200, body: TestFixtures.json("meetings.json")}

      %{method: :get, url: "https://api.zoom.us/v2/metrics/meetings/123/participants"} ->
        %Tesla.Env{status: 200, body: TestFixtures.json("meeting_participants_1.json")}
    end)

    :ok
  end

  test "get user details" do
    assert {:ok, body} = ZoomApi.user_details("user-123")
    assert body["id"] == "usr123"
  end

  test "get non-existent user" do
    assert {:error, {404, body}} = ZoomApi.user_details("does-not-exist")
    assert body["message"] =~ ~r/User does not exist/
  end

  test "get meetings" do
    assert {:ok, body} = ZoomApi.list_meetings()

    [first_meeting | _] = body["meetings"]
    assert %{"id" => 1_111_111} = first_meeting
  end

  test "get participants" do
    assert {:ok, body} = ZoomApi.list_meeting_participants(123)

    [part_1 | _] = body["participants"]
    assert %{"user_name" => "Chet"} = part_1
  end
end
