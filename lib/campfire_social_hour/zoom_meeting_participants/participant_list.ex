defmodule CampfireSocialHour.ZoomMeetingParticipants.ParticipantList do
  @moduledoc false
  import CampfireSocialHour.Meetings.Meeting, only: [canonize_id: 1]

  def new() do
    %{}
  end

  def update(part_list, meeting_id, new_participants) do
    part_list
    |> Map.put(canonize_id(meeting_id), new_participants)
  end

  def delete(part_list, meeting_id) do
    part_list
    |> Map.delete(canonize_id(meeting_id))
  end

  def get(part_list, meeting_id) do
    part_list
    |> Map.get(canonize_id(meeting_id), [])
  end

  def whitelist_meetings(list, meeting_ids) do
    good_keys =
      meeting_ids
      |> Enum.map(&canonize_id/1)
      |> MapSet.new()

    bad_keys =
      list
      |> Map.keys()
      |> Enum.reject(&MapSet.member?(good_keys, &1))

    Map.drop(list, bad_keys)
  end

  def add_participant(part_list, meeting_id, participant) do
    meeting_id = canonize_id(meeting_id)

    new_participants =
      part_list
      |> get(meeting_id)
      |> List.insert_at(0, participant)
      |> Enum.uniq_by(&participant_key/1)

    update(part_list, meeting_id, new_participants)
  end

  def remove_participant(part_list, meeting_id, participant) do
    meeting_id = canonize_id(meeting_id)
    _remove_participant(part_list, meeting_id, participant, Map.has_key?(part_list, meeting_id))
  end

  defp _remove_participant(part_list, _meeting_id, _participant, _meeting_id_exists = false) do
    part_list
  end

  defp _remove_participant(part_list, meeting_id, participant, _meeting_id_exists = true) do
    new_meeting_participants =
      part_list
      |> get(meeting_id)
      |> Enum.reject(fn p -> participant_key(p) == participant_key(participant) end)

    update(part_list, meeting_id, new_meeting_participants)
  end

  defp participant_key(%{"user_id" => user_id}), do: user_id
  defp participant_key(p), do: p
end
