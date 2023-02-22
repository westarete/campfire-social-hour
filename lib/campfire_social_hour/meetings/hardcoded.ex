defmodule CampfireSocialHour.Meetings.Hardcoded do
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "Botanical Garden",
        id: 6_063_966_747,
        link: "https://westarete.zoom.us/j/6063966747?pwd=T04vUGMwNnk4dTh4dkFaemE5OWRiZz09"
      },
      %Meeting{
        topic: "Greek Theater",
        id: 82_914_677_712,
        link: "https://us02web.zoom.us/j/82914677712?pwd=MFJiTytkR2lvQitUS01IY3hLR0pYUT09"
      },
      %Meeting{
        topic: "Faculty Glade",
        id: 85_789_329_053,
        link: "https://us02web.zoom.us/j/85789329053?pwd=ZzJBVzFGM2x5VHJEQkpYWnhlUmpPdz09"
      },
      %Meeting{
        topic: "Berkeley Art Museum/Pacific Film Archive",
        id: 82_271_294_034,
        link: "https://us02web.zoom.us/j/82271294034?pwd=UWJUbU9yL3cxT3l3djNQaE5naEJ4QT09"
      },
      %Meeting{
        topic: "Memorial Stadium",
        id: 88_571_531_135,
        link: "https://us02web.zoom.us/j/88571531135?pwd=dmM4YlFNWS9TR29XVlFkUkt6b3hCZz09"
      },
      %Meeting{
        topic: "The T-Rex at Valley Life Sciences",
        id: 83_008_721_265,
        link: "https://us02web.zoom.us/j/83008721265?pwd=MUIwTkU2K1I1ME9rb3BMeGJ2U1F5UT09"
      }
    ]
  end
end
