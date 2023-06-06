defmodule CampfireSocialHour.ZoomCredentialAgent do
  @moduledoc """
  Agent responsible for maintaining zoom client credential state
  """
  use Agent
  require Logger

  @type state ::
          nil
          | %{
              access_token: String.t(),
              expires_at: integer
            }

  def start_link(_arg),
    do: Agent.start_link(fn -> nil end, name: __MODULE__)

  @spec access_token :: String.t()
  def access_token(), do: Agent.get_and_update(__MODULE__, &get_and_update_token/1)

  @spec get_token() :: state
  defp get_token() do
    debug("Getting Access Token")

    case zoom_api().get_access_token() do
      {:ok, %{access_token: access_token, expires_in: expires_in}} ->
        %{access_token: access_token, expires_at: now() + expires_in}

      :error ->
        nil
    end
  end

  @spec token_to_update_tuple(nil | map) :: {nil | String.t(), state}
  defp token_to_update_tuple(token) do
    case token do
      %{access_token: access_token, expires_at: _} = new_state -> {access_token, new_state}
      nil = new_state -> {nil, new_state}
    end
  end

  @spec get_and_update_token(state) :: {String.t(), state}
  defp get_and_update_token(_state = nil) do
    debug("Token not set, Fetching")

    get_token()
    |> token_to_update_tuple()
  end

  defp get_and_update_token(state = %{expires_at: expires_at, access_token: access_token}) do
    if now() + 1 > expires_at do
      debug("Token Expired, Refreshing")

      get_token()
      |> token_to_update_tuple()
    else
      debug("Token Valid, Reusing")
      {access_token, state}
    end
  end

  @spec now() :: integer
  defp now(), do: :os.system_time(:seconds)

  defp zoom_api(), do: Application.fetch_env!(:campfire_social_hour, :zoom_api)

  defp debug(msg), do: Logger.debug("[Zoom Credential Agent] #{msg}")
end
