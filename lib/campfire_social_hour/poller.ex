defmodule CampfireSocialHour.Poller do
  @moduledoc false
  use GenServer

  alias CampfireSocialHour.Poller.{MeetingsPoller, ParticipantsPoller}

  require Logger

  @meeting_refresh_interval 127_000
  @particitant_refresh_interval 31_000

  # 30 reqs per second
  @api_delay 33

  def start_link(_), do: GenServer.start_link(__MODULE__, [])

  def api_delay(), do: @api_delay

  @impl true
  def init(_) do
    schedule_meetings_refresh()
    schedule_participant_refresh()

    Process.send(self(), :init_apis, [])

    {:ok, nil}
  end

  @impl true
  def handle_info(:update_participants, state) do
    participants_adapter().fetch_and_update()
    schedule_participant_refresh()
    {:noreply, state}
  end

  @impl true
  def handle_info(:update_meetings, state) do
    meetings_adapter().fetch_and_update()
    schedule_meetings_refresh()
    {:noreply, state}
  end

  @impl true
  def handle_info(:init_apis, state) do
    meetings_adapter().fetch_and_update()
    :timer.sleep(api_delay())
    participants_adapter().fetch_and_update()

    {:noreply, state}
  end

  defp schedule_meetings_refresh() do
    Process.send_after(self(), :update_meetings, @meeting_refresh_interval)
  end

  defp schedule_participant_refresh() do
    Process.send_after(self(), :update_participants, @particitant_refresh_interval)
  end

  # Allows us to inject a mock poller in the test environment via test.exs
  # but use the real MeetingsPoller in other environments
  defp meetings_adapter() do
    Application.get_env(
      :campfire_social_hour,
      :meetings_poller_adapter,
      MeetingsPoller
    )
  end

  # Allows us to inject a mock poller in the test environment via test.exs
  # but use the real ParticipantsPoller in other environments
  defp participants_adapter() do
    Application.get_env(
      :campfire_social_hour,
      :participants_poller_adapter,
      ParticipantsPoller
    )
  end
end
