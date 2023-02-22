defmodule CampfireSocialHour.Meetings.Hardcoded do
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "Botanical Garden",
        id: 81_441_354_730,
        link: "https://westarete.zoom.us/j/81441354730?pwd=TU8zakhpcnF0U3hvcks0VEd4eDMrUT09"
      },
      %Meeting{
        topic: "Greek Theater",
        id: 86_558_209_179,
        link: "https://westarete.zoom.us/j/86558209179?pwd=M3NGanVJY0dZOWpURnlCcHBRU0xiUT09"
      },
      %Meeting{
        topic: "Faculty Glade",
        id: 82_646_774_113,
        link: "https://westarete.zoom.us/j/82646774113?pwd=dm05ajBXTXZKV3d4blBzRmh2SGZXdz09"
      },
      %Meeting{
        topic: "Berkeley Art Museum/Pacific Film Archive",
        id: 87_935_374_724,
        link: "https://westarete.zoom.us/j/87935374724?pwd=S2R5REIzQnJjY3UyMitDdmV2T3pHUT09"
      },
      %Meeting{
        topic: "Memorial Stadium",
        id: 81_517_984_710,
        link: "https://westarete.zoom.us/j/81517984710?pwd=LzJnekZzUzZneTZ4emNnY29IWERrQT09"
      },
      %Meeting{
        topic: "The T-Rex at Valley Life Sciences",
        id: 81_743_364_881,
        link: "https://westarete.zoom.us/j/81743364881?pwd=RVE2c2JOaEtnN3dDV1l0cjFBcEZOZz09"
      }
    ]
  end
end
