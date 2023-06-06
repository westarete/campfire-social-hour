defmodule CampfireSocialHour.ZoomApi do
  @moduledoc false
  @behaviour CampfireSocialHour.ZoomApiBehavior

  alias CampfireSocialHour.ZoomApi.Client
  alias CampfireSocialHour.ZoomApi.OauthClient
  alias CampfireSocialHour.ZoomCredentialAgent

  def user_details(user_id), do: Client.user_details(client(), user_id)

  def list_meetings(), do: Client.list_meetings(client())

  def list_meeting_participants(meeting_id),
    do: Client.list_meeting_participants(client(), meeting_id)

  defdelegate get_access_token(), to: OauthClient

  defp client(), do: Client.new(ZoomCredentialAgent.access_token())
end
