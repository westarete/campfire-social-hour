defmodule CampfireSocialHourWeb.PageController do
  use CampfireSocialHourWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
