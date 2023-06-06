defmodule CampfireSocialHour.Meetings.StatusServer do
  @moduledoc false
  use Agent

  import CampfireSocialHour.Meetings.Meeting, only: [canonize_id: 1]

  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    Agent.start_link(fn -> MapSet.new() end, name: opts[:name])
  end

  def active?(name \\ __MODULE__, meeting_id) do
    Agent.get(name, &MapSet.member?(&1, canonize_id(meeting_id)))
  end

  def set_active(name \\ __MODULE__, meeting_id) do
    Agent.update(name, &MapSet.put(&1, canonize_id(meeting_id)))
  end

  def set_inactive(name \\ __MODULE__, meeting_id) do
    Agent.update(name, &MapSet.delete(&1, canonize_id(meeting_id)))
  end

  def update_all_active(name \\ __MODULE__, meeting_id_list) do
    new_set =
      meeting_id_list
      |> Enum.map(&canonize_id/1)
      |> MapSet.new()

    Agent.update(name, fn _ -> new_set end)
  end
end
