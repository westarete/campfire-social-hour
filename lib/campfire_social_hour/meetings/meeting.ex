defmodule CampfireSocialHour.Meetings.Meeting do
  @moduledoc false
  defstruct [:id, :topic, :link]

  def canonize_id(id), do: to_string(id)
end
