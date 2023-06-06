defmodule CampfireSocialHour.ZoomApiBehavior do
  @callback get_access_token() :: {:ok, map} | :error
end
