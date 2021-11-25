defmodule CampfireSocialHourWeb.MeetingLive.Index do
  use CampfireSocialHourWeb, :live_view

  alias CampfireSocialHour.{Participants, Meetings, ZoomMeetingParticipants}

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Participants.subscribe()

    {:ok, assign(socket, :meetings, load_meetings())}
  end

  @impl true
  def handle_info(:participants_updated, socket) do
    {:noreply, update(socket, :meetings, fn _old -> load_meetings() end)}
  end

  def participant_list(participants, limit \\ 8) do
    truncated_participants =
      participants
      |> Enum.take(limit)
      |> Enum.map(fn %{"user_name" => user_name} -> user_name end)

    overflow = length(participants) - limit

    do_participant_list(truncated_participants, overflow)
  end

  defp load_meetings() do
    ZoomMeetingParticipants.get()
    |> Meetings.list_meetings_with_participants()
  end

  defp do_participant_list(truncated_names, _overflow = 1) do
    List.insert_at(truncated_names, -1, "and 1 other")
  end

  defp do_participant_list(truncated_names, overflow) when 1 < overflow do
    List.insert_at(truncated_names, -1, "and #{overflow} others")
  end

  defp do_participant_list(truncated_names, _) do
    truncated_names
  end
end
