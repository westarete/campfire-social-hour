defmodule CampfireSocialHour.Meetings.Hardcoded do
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "Ashburn",
        id: 88_168_094_255,
        link: "https://us02web.zoom.us/j/88168094255?pwd=SjY0N0VCaTdyRzMwZ1ArajZwemZqUT09"
      },
      %Meeting{
        topic: "Chicago",
        id: 89_509_434_465,
        link: "https://us02web.zoom.us/j/89509434465?pwd=VnlBazNnemYzWkM2ZnVIeklKOUJ0UT09"
      },
      %Meeting{
        topic: "Dallas",
        id: 88_241_709_171,
        link: "https://us02web.zoom.us/j/88241709171?pwd=WEJ1OWZiejdkZlVYMnNSOEVrTXdEQT09"
      },
      %Meeting{
        topic: "San Jose",
        id: 81_323_197_405,
        link: "https://us02web.zoom.us/j/81323197405?pwd=b3hjaE1rMDFGVExaRk5RRzNyOVVmZz09"
      },
      %Meeting{
        topic: "NYC",
        id: 85_141_035_586,
        link: "https://us02web.zoom.us/j/85141035586?pwd=VEZOejhDaDFpSVdaeGF5TFFDSUdZZz09"
      },
      %Meeting{
        topic: "Seattle",
        id: 83_871_293_505,
        link: "https://us02web.zoom.us/j/83871293505?pwd=bXBjamxvdGxkMHVVcmVYa1VxY2VtZz09"
      }
    ]
  end
end
