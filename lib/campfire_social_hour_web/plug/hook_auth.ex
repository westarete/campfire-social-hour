defmodule CampfireSocialHourWeb.Plug.HookAuth do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    allowed_token = Application.fetch_env!(:campfire_social_hour, :webhook_token)
    provided_tokens = get_req_header(conn, "authorization")

    authorize(conn, allowed_token in provided_tokens)
  end

  defp authorize(conn, _header_match = true), do: conn

  defp authorize(conn, _header_no_match) do
    conn
    |> send_resp(401, "Not authorized")
    |> halt()
  end
end
