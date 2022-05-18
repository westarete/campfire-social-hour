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
        topic: "Appalachian",
        id: 82_914_677_712,
        link: "https://us02web.zoom.us/j/82914677712?pwd=MFJiTytkR2lvQitUS01IY3hLR0pYUT09"
      },
      %Meeting{
        topic: "Ice Age",
        id: 85_789_329_053,
        link: "https://us02web.zoom.us/j/85789329053?pwd=ZzJBVzFGM2x5VHJEQkpYWnhlUmpPdz09"
      },
      %Meeting{
        topic: "Oregon",
        id: 82_271_294_034,
        link: "https://us02web.zoom.us/j/82271294034?pwd=UWJUbU9yL3cxT3l3djNQaE5naEJ4QT09"
      },
      %Meeting{
        topic: "Moria",
        id: 88_571_531_135,
        link: "https://us02web.zoom.us/j/88571531135?pwd=dmM4YlFNWS9TR29XVlFkUkt6b3hCZz09"
      },
      %Meeting{
        topic: "Colorado",
        id: 83_008_721_265,
        link: "https://us02web.zoom.us/j/83008721265?pwd=MUIwTkU2K1I1ME9rb3BMeGJ2U1F5UT09"
      },
      %Meeting{
        topic: "Mountains to Sea",
        id: 86_242_087_705,
        link: "https://us02web.zoom.us/j/85242087705?pwd=V1d2Wmc4OU44YmRGWkpLOHMwSW12UT09"
      },
      %Meeting{
        topic: "Fox River",
        id: 83_914_677_712,
        link: "https://us02web.zoom.us/j/82914677712?pwd=MFJiTytkR2lvQitUS01IY3hLR0pYUT09"
      },
      %Meeting{
        topic: "Allegheny",
        id: 86_789_329_053,
        link: "https://us02web.zoom.us/j/85789329053?pwd=ZzJBVzFGM2x5VHJEQkpYWnhlUmpPdz09"
      },
      %Meeting{
        topic: "Bigfoot",
        id: 83_271_294_034,
        link: "https://us02web.zoom.us/j/82271294034?pwd=UWJUbU9yL3cxT3l3djNQaE5naEJ4QT09"
      },
      %Meeting{
        topic: "High Sierra",
        id: 89_571_531_135,
        link: "https://us02web.zoom.us/j/88571531135?pwd=dmM4YlFNWS9TR29XVlFkUkt6b3hCZz09"
      },
      %Meeting{
        topic: "Continental Divide",
        id: 84_008_721_265,
        link: "https://us02web.zoom.us/j/83008721265?pwd=MUIwTkU2K1I1ME9rb3BMeGJ2U1F5UT09"
      }
    ]
  end
end
