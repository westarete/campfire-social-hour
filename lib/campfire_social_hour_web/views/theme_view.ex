defmodule CampfireSocialHourWeb.ThemeView do
  use CampfireSocialHourWeb, :view

  alias CampfireSocialHourWeb.Theme

  @moduledoc """
  Keeps track of the currently active theme and knows how to render templates for it.

  Also provides convenience helpers for the layout.
  """

  def render(template, assigns) do
    Path.join(current_theme_slug(), template)
    |> render_template(assigns)
  end

  def title, do: current_theme().title
  def title_suffix, do: " - #{current_theme().title_suffix}"
  def css_file, do: current_theme_slug()

  defp current_theme_slug do
    current_theme().slug
    |> to_string()
  end

  defp current_theme, do: Theme.current()
end
