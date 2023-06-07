defmodule CampfireSocialHour.ZoomApi.OauthClient do
  @moduledoc """
  Client for interacting with zoom's oauth flow
  """
  def get_access_token() do
    case Tesla.post(client(), "/oauth/token", nil,
           query: [grant_type: "account_credentials", account_id: account_id()]
         ) do
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body}
    end
  end

  defp client() do
    [
      {Tesla.Middleware.BaseUrl, "https://zoom.us/"},
      {Tesla.Middleware.BasicAuth, username: client_id(), password: client_secret()},
      {Tesla.Middleware.JSON, engine_opts: [keys: :atoms]}
    ]
    |> Tesla.client()
  end

  defp client_id(), do: fetch_env!(:client_id)
  defp client_secret(), do: fetch_env!(:client_secret)
  defp account_id(), do: fetch_env!(:account_id)
  defp fetch_env!(attr), do: Application.fetch_env!(:campfire_social_hour, attr)
end
