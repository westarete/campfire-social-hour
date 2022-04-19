defmodule CampfireSocialHourWeb.MeetingLive.Index do
  use CampfireSocialHourWeb, :live_view

  alias CampfireSocialHour.{Participants, Meetings, ZoomMeetingParticipants}
  alias CampfireSocialHourWeb.MeetingLive.MeetingComponent

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Participants.subscribe()

    socket =
      socket
      |> assign(:meetings, load_meetings())
      # Needed to show instructions in header
      |> assign(:instructions, true)

    {:ok, socket}
  end

  @impl true
  def handle_info(:participants_updated, socket) do
    {:noreply, update(socket, :meetings, fn _old -> load_meetings() end)}
  end

  def participant_names(participants) do
    participants
    |> Enum.reverse()
    |> Enum.map(fn %{"user_name" => user_name} -> user_name end)
  end

  defp load_meetings() do
    ZoomMeetingParticipants.get()
    |> Meetings.list_meetings_with_participants()
  end
end
