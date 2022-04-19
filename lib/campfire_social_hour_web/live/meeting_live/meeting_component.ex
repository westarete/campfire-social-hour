defmodule CampfireSocialHourWeb.MeetingLive.MeetingComponent do
  use CampfireSocialHourWeb, :live_component

  def render(assigns) do
    assigns =
      Map.put(assigns, :link_aria_label, link_aria_label(assigns.topic, assigns.participants))

    render(CampfireSocialHourWeb.ThemeView, "_meeting_component.html", assigns)
  end

  defp link_aria_label(topic, participants) do
    "Join the #{topic} room #{do_link_participants(length(participants))}"
  end

  defp do_link_participants(_n = 0), do: "and you'll be the only one there"
  defp do_link_participants(_n = 1), do: "with 1 other person"
  defp do_link_participants(n), do: "with #{n} other people"
end
