defmodule CampfireSocialHour.ZoomCredentialAgent do
  @moduledoc """
  Agent responsible for maintaining zoom client credential state
  """
  use Agent
  require Logger

  alias CampfireSocialHour.ZoomApi

  @type state :: %{
          access_token: String.t(),
          expires_at: integer
        }

  def start_link(_arg), do: Agent.start_link(&get_token/0, name: __MODULE__)

  @spec access_token :: String.t()
  def access_token(), do: Agent.get_and_update(__MODULE__, &get_and_update_token/1)

  @spec get_token() :: state
  defp get_token() do
    debug("Getting Access Token")

    case ZoomApi.get_access_token() do
      {:ok, %{access_token: access_token, expires_in: expires_in}} ->
        %{access_token: access_token, expires_at: now() + expires_in}
    end
  end

  @spec get_and_update_token(state) :: {String.t(), state}
  defp get_and_update_token(%{expires_at: expires_at, access_token: access_token} = state) do
    if now() + 1 > expires_at do
      debug("Token Expired, Refreshing")
      new_state = get_token()
      {new_state.access_token, new_state}
    else
      debug("Token Valid, Reusing")
      {access_token, state}
    end
  end

  @spec now() :: integer
  defp now(), do: :os.system_time(:seconds)

  defp debug(msg), do: Logger.debug("[Zoom Credential Agent] #{msg}")
end
