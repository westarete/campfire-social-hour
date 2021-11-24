defmodule CampfireSocialHour.Meetings.MockData do
  def list_meetings() do
    [
      %{
        id: 1,
        topic: "topic 1 but this one should be long",
        participants: random_participants("Julia"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 2,
        topic: "TOPIC 2",
        participants: random_participants("Ryan"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 3,
        topic: "topic 3",
        participants: random_participants("Scott"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 4,
        topic: "topic 4",
        participants: random_participants("Chet"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 5,
        topic: "topic 5",
        participants: random_participants("Eric"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 6,
        topic: "topic 6",
        participants: random_participants("Natalie"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 7,
        topic: "topic 7",
        participants: random_participants("Chris"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 8,
        topic: "topic 8",
        participants: random_participants("Henry"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 9,
        topic: "topic 9",
        participants: random_participants("Greg"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 10,
        topic: "topic 10",
        participants: random_participants("Chuck"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 11,
        topic: "topic 11",
        participants: random_participants("Robo"),
        link: "https://github.com/jgiwinski/"
      },
      %{
        id: 12,
        topic: "topic 12",
        participants: random_participants("Dez"),
        link: "https://github.com/jgiwinski/"
      }
    ]
  end

  def random_participants(name, min \\ 2, max \\ 10) do
    1..Enum.random(min..max)
    |> Enum.map(fn n -> "#{name} #{n}" end)
  end
end
