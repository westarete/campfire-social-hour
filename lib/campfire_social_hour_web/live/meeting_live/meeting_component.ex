defmodule CampfireSocialHourWeb.MeetingLive.MeetingComponent do
  use CampfireSocialHourWeb, :live_component

  def render(assigns) do
    ~H"""
      <div id={"meeting_#{@id}"} class="column column-25">
        <h4><%= @topic %></h4>
        <div><%= link "Join", to: @link, class: "button button-small", target: "_blank" %></div>
        <div id={"participant_list_#{@id}"} class="participant-list">
          <%= for name <- @participants do %>
            <div><%= name %></div>
          <% end %>
        </div>
      </div>
    """
  end
end
