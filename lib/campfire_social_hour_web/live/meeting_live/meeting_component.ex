defmodule CampfireSocialHourWeb.MeetingLive.MeetingComponent do
  use CampfireSocialHourWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="col" id={"meeting-#{@id}"} aria-label={"#{@topic} room"}>
        <div class="room-wrapper">
          <div class="room">

            <a href={@link} class="room-title" target="_blank" aria_label={link_aria_label(@topic, @participants)} >
              <img src="/images/room-icon.png" role="presentation" alt="" />
              <h3><%= @topic %></h3>
            </a>

            <ul class="room-data" id={"participants-#{@id}"} aria-label={"People in the #{@topic} room"} role='list'>
              <%= for name <- @participants do %>
                <li><%= name %></li>
              <% end %>
            </ul>

          </div>
        </div>
      </div>
    """
  end

  defp link_aria_label(topic, participants) do
    "Join the #{topic} room, #{do_link_participants(length(participants))}"
  end

  defp do_link_participants(_n = 0), do: "and you'll be the only one there"
  defp do_link_participants(_n = 1), do: "with 1 other person"
  defp do_link_participants(n), do: "with #{n} other people"
end
