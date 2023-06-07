defmodule CampfireSocialHour.ZoomApiBehavior do
  @moduledoc """
  Behavior for Zoom API
  """
  @callback get_access_token() :: {:ok, map} | :error
end
