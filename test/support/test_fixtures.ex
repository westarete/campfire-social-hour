defmodule CampfireSocialHour.TestFixtures do
  def json(filename) do
    filename
    |> file()
    |> Jason.decode!()
  end

  def file(filename) do
    "../fixtures/#{filename}"
    |> Path.expand(__DIR__)
    |> File.read!()
  end
end
