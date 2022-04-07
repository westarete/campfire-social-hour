defmodule CampfireSocialHour.Meetings.StatusServerTest do
  use ExUnit.Case, async: true
  alias CampfireSocialHour.Meetings.StatusServer

  setup %{test: name} do
    {:ok, pid} = StatusServer.start_link(name: name)

    {:ok, name: name, pid: pid}
  end

  test "maintains a set of active meetings", %{name: name} do
    refute StatusServer.active?(name, "my_meeting")

    StatusServer.set_active(name, "my_meeting")
    assert StatusServer.active?(name, "my_meeting")

    StatusServer.set_inactive(name, "my_meeting")
    refute StatusServer.active?(name, "my_meeting")
  end

  test "can be reset to a provided list", %{name: name} do
    StatusServer.set_active(name, "my_meeting")

    StatusServer.update_all_active(name, ~w[one two])

    refute StatusServer.active?(name, "my_meeting")
    assert StatusServer.active?(name, "one")
    assert StatusServer.active?(name, "two")
  end

  test "canonizes the given meeting names", %{name: name} do
    StatusServer.set_active(name, 1)
    assert StatusServer.active?(name, 1)
    assert StatusServer.active?(name, "1")

    StatusServer.set_inactive(name, "1")
    refute StatusServer.active?(name, 1)
    refute StatusServer.active?(name, "1")

    StatusServer.update_all_active(name, [1, "2"])
    assert StatusServer.active?(name, "1")
    assert StatusServer.active?(name, 2)
  end
end
