defmodule CampfireSocialHourWeb.PageController do
  use CampfireSocialHourWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def about(conn, _params) do
    render(conn, "about.html")
  end
end
