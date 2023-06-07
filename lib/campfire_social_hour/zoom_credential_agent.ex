defmodule CampfireSocialHour.ZoomCredentialAgent do
  @moduledoc """
  Zoom credential agent for managing an active api token
  """
  use GenServer
  require Logger

  @refresh_threshold 5 * 60

  @type state :: %{access_token: String.t()}

  def start_link(opts \\ []),
    do: GenServer.start_link(__MODULE__, nil, name: opts[:name] || __MODULE__)

  def access_token(name \\ __MODULE__, timeout \\ 5000), do: GenServer.call(name, :fetch, timeout)

  @impl true
  def init(nil), do: {:ok, nil, {:continue, nil}}

  @impl true
  def handle_continue(nil, nil) do
    debug("Building initial state")
    token = request_token_and_schedule_refresh()

    {:noreply, %{access_token: token.access_token}}
  end

  @impl true
  def handle_call(:fetch, _from, state) do
    if state.access_token do
      debug("Token available, reusing:", state)
      {:reply, state.access_token, state}
    else
      debug("Token not available, refetching...")

      token = request_token_and_schedule_refresh()

      {:reply, token.access_token, %{state | access_token: token.access_token}}
    end
  end

  @impl true
  def handle_info(:refresh, state) do
    debug("Refreshing token...")

    token = request_token_and_schedule_refresh()
    {:noreply, %{state | access_token: token.access_token}}
  end

  defp request_token_and_schedule_refresh(),
    do: request_token() |> tap(&schedule_refresh/1)

  defp request_token do
    debug("Requesting Token...")

    case zoom_api().get_access_token() do
      {:ok, token} ->
        debug("-> Token received:", token)
        token
    end
  end

  defp schedule_refresh(%{expires_in: expires_in}) do
    refresh_in = abs(expires_in - @refresh_threshold) * 1000
    debug("Scheduling Refresh for: #{refresh_in}")
    Process.send_after(self(), :refresh, refresh_in)
  end

  defp zoom_api(), do: Application.fetch_env!(:campfire_social_hour, :zoom_api)

  defp debug(msg), do: Logger.debug("[Zoom Credential Agent] #{msg}")

  defp debug(msg, %{access_token: access_token}) do
    [msg, "#{String.slice(access_token, 0..10)}..."]
    |> Enum.join(" ")
    |> debug()
  end
end
