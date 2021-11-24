defmodule CampfireSocialHour.Meetings.Meeting do
  defstruct [:id, :topic, :link]

  def canonize_id(id), do: to_string(id)
end
