defmodule CampfireSocialHour.ZoomMeetingParticipants.ParticipantServer do
  use Agent

  @moduledoc """
  This is a Genserver wrapper around `CampfireSocialHour.ZoomMeetingParticipants.ParticipantList`
  to maintain state
  """

  alias CampfireSocialHour.ZoomMeetingParticipants.ParticipantList

  def start_link(_) do
    Agent.start_link(&ParticipantList.new/0, name: __MODULE__)
  end

  def update(meeting_id, new_participants) do
    Agent.update(__MODULE__, &ParticipantList.update(&1, meeting_id, new_participants))
  end

  def get() do
    Agent.get(__MODULE__, fn list -> list end)
  end

  def whitelist_meetings(meeting_ids) do
    Agent.update(__MODULE__, &ParticipantList.whitelist_meetings(&1, meeting_ids))
  end

  def delete(meeting_id) do
    Agent.update(__MODULE__, &ParticipantList.delete(&1, meeting_id))
  end

  def add_participant(meeting_id, participant) do
    Agent.update(__MODULE__, &ParticipantList.add_participant(&1, meeting_id, participant))
  end

  def remove_participant(meeting_id, participant) do
    Agent.update(__MODULE__, &ParticipantList.remove_participant(&1, meeting_id, participant))
  end
end
