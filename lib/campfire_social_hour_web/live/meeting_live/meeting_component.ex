defmodule CampfireSocialHourWeb.MeetingLive.MeetingComponent do
  use CampfireSocialHourWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="col" id={"meeting-#{@id}"} aria-label={"#{@topic} room"}>
        <div class="room-wrapper">
          <div class="room">

            <div class="room-title">
              <img src="/images/room-icon.png" role="presentation" alt="" />
              <h3>
                <%= link @topic, to: @link, class: "button button-small", target: "_blank", aria_label: "Join the #{@topic} room" %>
              </h3>
            </div>

            <ul class="room-data" id={"participants-#{@id}"} aria-label={"Members in the #{@topic} room"} role='list'>
              <%= for name <- @participants do %>
                <li><%= name %></li>
              <% end %>
            </ul>

          </div>
        </div>
      </div>
    """
  end
end
