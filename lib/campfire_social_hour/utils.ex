defmodule CampfireSocialHour.Utils do
  @moduledoc """
  Utility functions
  """

  @doc """
  Enables easily returning an OK tuple from a pipeline
  """
  def ok(term), do: {:ok, term}
end
