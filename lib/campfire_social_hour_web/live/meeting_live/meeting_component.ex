defmodule CampfireSocialHourWeb.MeetingLive.MeetingComponent do
  use CampfireSocialHourWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="col-md-6 col-sm-6" id={"meeting-#{@id}"}>
        <div class="services-box">
          <div class="services-row">
            <div class="services-img">
              <img src="images/service-img.png" alt="">
              <h3>
                <%= link @topic, to: @link, class: "button button-small", target: "_blank" %>
              </h3>
            </div>
            <div class="service-data">
              <ul id={"participants-#{@id}"}>
                <%= for name <- @participants do %>
                  <li><%= name %></li>
                <% end %>
              </ul>
            </div>
          </div>
        </div>
      </div>
    """
  end
end
