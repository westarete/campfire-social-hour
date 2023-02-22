defmodule CampfireSocialHourWeb.Theme do
  @moduledoc """
  Defines the available UI themes and returns the currently active one.
  """
  defstruct [:slug, :title, :title_suffix]

  @type theme_slug :: :theme_campfire | :theme_techextra | :theme_berkeley

  @type t :: %__MODULE__{
          slug: theme_slug(),
          title: String.t(),
          title_suffix: String.t() | nil
        }

  @spec current() :: __MODULE__.t()
  def current do
    Application.fetch_env!(:campfire_social_hour, :theme)
    |> current()
  end

  defp current("campfire") do
    %__MODULE__{
      slug: :theme_campfire,
      title: "BaseCAMP Fires",
      title_suffix: nil
    }
  end

  defp current("techextra") do
    %__MODULE__{
      slug: :theme_techextra,
      title: "Social Hour",
      title_suffix: "Internet2 TechEXtra"
    }
  end

  defp current("berkeley") do
    %__MODULE__{
      slug: :theme_berkeley,
      title: "Social Lounge",
      title_suffix: "Berkeley"
    }
  end
end
