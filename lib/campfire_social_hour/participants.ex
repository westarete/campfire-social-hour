defmodule CampfireSocialHour.Participants do
  @moduledoc false
  def subscribe do
    Phoenix.PubSub.subscribe(CampfireSocialHour.PubSub, "participants")
  end

  def broadcast_update(), do: broadcast(:ok, :participants_updated)

  defp broadcast(:ok, event) do
    Phoenix.PubSub.broadcast(CampfireSocialHour.PubSub, "participants", event)
    :ok
  end
end
