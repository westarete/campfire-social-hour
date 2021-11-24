defmodule CampfireSocialHour.ZoomApi do
  alias CampfireSocialHour.ZoomApi.Client

  defdelegate user_details(user_id), to: Client

  defdelegate list_meetings(), to: Client

  defdelegate list_meeting_participants(meeting_id), to: Client
end
