defmodule CampfireSocialHour.Meetings.StatusServer do
  use Agent

  import CampfireSocialHour.Meetings.Meeting, only: [canonize_id: 1]

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def active?(meeting_id) do
    Agent.get(__MODULE__, &Map.get(&1, canonize_id(meeting_id), false))
  end

  def set_active(meeting_id) do
    Agent.update(__MODULE__, &Map.put(&1, canonize_id(meeting_id), true))
  end

  def set_inactive(meeting_id) do
    Agent.update(__MODULE__, &Map.put(&1, canonize_id(meeting_id), false))
  end

  def update_all_active(meeting_id_list) do
    all_true =
      meeting_id_list
      |> Enum.map(&canonize_id/1)
      |> Enum.into(%{}, fn id -> {id, true} end)

    Agent.update(__MODULE__, fn _ -> all_true end)
  end
end
