defmodule CampfireSocialHour.ZoomApiStub do
  @moduledoc """
  Default stub for Zoom API with a happy-path default
  """
  @behaviour CampfireSocialHour.ZoomApiBehavior

  def get_access_token(), do: {:ok, %{access_token: "abc123", expires_in: 3600}}
end
