defmodule CampfireSocialHour.Meetings.Hardcoded do
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "Pacific Crest",
        id: 85_242_087_705,
        link: "https://us02web.zoom.us/j/85242087705?pwd=V1d2Wmc4OU44YmRGWkpLOHMwSW12UT09"
      },
      %Meeting{
        topic: "Oregon",
        id: 82_914_677_712,
        link: "https://us02web.zoom.us/j/82914677712?pwd=MFJiTytkR2lvQitUS01IY3hLR0pYUT09"
      },
      %Meeting{
        topic: "Mountains to Sea",
        id: 85_789_329_053,
        link: "https://us02web.zoom.us/j/85789329053?pwd=ZzJBVzFGM2x5VHJEQkpYWnhlUmpPdz09"
      },
      %Meeting{
        topic: "Bigfoot",
        id: 82_271_294_034,
        link: "https://us02web.zoom.us/j/82271294034?pwd=UWJUbU9yL3cxT3l3djNQaE5naEJ4QT09"
      },
      %Meeting{
        topic: "Appalachian",
        id: 88_571_531_135,
        link: "https://us02web.zoom.us/j/88571531135?pwd=dmM4YlFNWS9TR29XVlFkUkt6b3hCZz09"
      },
      %Meeting{
        topic: "Moria",
        id: 83_008_721_265,
        link: "https://us02web.zoom.us/j/83008721265?pwd=MUIwTkU2K1I1ME9rb3BMeGJ2U1F5UT09"
      },
      %Meeting{
        topic: "Fox River",
        id: 86_568_799_831,
        link: "https://us02web.zoom.us/j/86568799831?pwd=QlpHTCtXUVVUd2t4M29PaS9oSzNNQT09"
      },
      %Meeting{
        topic: "High Sierra",
        id: 89_026_387_030,
        link: "https://us02web.zoom.us/j/89026387030?pwd=L1ZWT3Z3ZVZrK1pDeS9wSlFmMWNVZz09"
      },
      %Meeting{
        topic: "Ice Age",
        id: 84_277_516_663,
        link: "https://us02web.zoom.us/j/84277516663?pwd=NmRwY2ZheGZoOVhsL3hhZHBlMmgxQT09"
      },
      %Meeting{
        topic: "Colorado",
        id: 84_043_368_581,
        link: "https://us02web.zoom.us/j/84043368581?pwd=SGcxNEY0VDIvaDl0SUkrVzV4TTlZdz09"
      },
      %Meeting{
        topic: "Allegheny",
        id: 86_802_304_569,
        link: "https://us02web.zoom.us/j/86802304569?pwd=VW1pVWlnMDdyZFp3dDJjdkpQdkVzUT09"
      },
      %Meeting{
        topic: "Continental Divide",
        id: 88_216_098_215,
        link: "https://us02web.zoom.us/j/88216098215?pwd=dTZPZDFhemhySFpHTE1OWUR4bUNsdz09"
      }
    ]
  end
end
