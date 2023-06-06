defmodule CampfireSocialHourWeb.Plug.HookAuth do
  @moduledoc false
  import Plug.Conn
  import CampfireSocialHour.Utils, only: [ok: 1]

  @signature_header "x-zm-signature"
  @timestamp_header "x-zm-request-timestamp"

  def init(options), do: options

  def call(conn, _opts) do
    with {:ok, signature} <- signature(conn),
         {:ok, timestamp} <- timestamp(conn),
         {:ok, digest} <- digest(timestamp, conn.assigns.raw_body),
         true <- authorized?(signature, digest) do
      conn
    else
      _ ->
        conn
        |> send_resp(401, "Not authorized")
        |> halt()
    end
  end

  defp signature(conn) do
    case get_req_header(conn, @signature_header) do
      ["v0=" <> signature] -> {:ok, signature}
      _ -> :error
    end
  end

  defp timestamp(conn) do
    case get_req_header(conn, @timestamp_header) do
      [timestamp] -> {:ok, timestamp}
      _ -> :error
    end
  end

  defp digest(timestamp, payload) do
    :crypto.mac(:hmac, :sha256, secret_token(), digest_msg(timestamp, payload))
    |> Base.encode16(case: :lower)
    |> ok()
  end

  defp digest_msg(timestamp, payload), do: "v0:#{timestamp}:#{payload}"

  defp authorized?(signature, digest), do: Plug.Crypto.secure_compare(signature, digest)

  defp secret_token(), do: Application.fetch_env!(:campfire_social_hour, :secret_token)
end
