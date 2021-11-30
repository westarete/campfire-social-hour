defmodule CampfireSocialHourWeb.MeetingLive.MeetingComponent do
  use CampfireSocialHourWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="col" id={"meeting-#{@id}"} aria-label={"#{@topic} room"}>
        <div class="room-wrapper">
          <div class="room">

            <%= link to: @link, class: "room-title", target: "_blank", aria_label: "Join the #{@topic} room" do %>
              <img src="/images/room-icon.png" role="presentation" alt="" />
              <h3><%= @topic %></h3>
            <% end %>

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
