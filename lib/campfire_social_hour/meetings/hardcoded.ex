defmodule CampfireSocialHour.Meetings.Hardcoded do
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "Ashburn",
        id: 85242087705,
        link: "https://us02web.zoom.us/j/85242087705?pwd=V1d2Wmc4OU44YmRGWkpLOHMwSW12UT09"
      },
      %Meeting{
        topic: "Chicago",
        id: 82914677712,
        link: "https://us02web.zoom.us/j/82914677712?pwd=MFJiTytkR2lvQitUS01IY3hLR0pYUT09"
      },
      %Meeting{
        topic: "Dallas",
        id: 85789329053,
        link: "https://us02web.zoom.us/j/85789329053?pwd=ZzJBVzFGM2x5VHJEQkpYWnhlUmpPdz09"
      },
      %Meeting{
        topic: "San Jose",
        id: 82271294034,
        link: "https://us02web.zoom.us/j/82271294034?pwd=UWJUbU9yL3cxT3l3djNQaE5naEJ4QT09"
      },
      %Meeting{
        topic: "NYC",
        id: 88571531135,
        link: "https://us02web.zoom.us/j/88571531135?pwd=dmM4YlFNWS9TR29XVlFkUkt6b3hCZz09"
      },
      %Meeting{
        topic: "Seattle",
        id: 83008721265,
        link: "https://us02web.zoom.us/j/83008721265?pwd=MUIwTkU2K1I1ME9rb3BMeGJ2U1F5UT09"
      }
    ]
  end
end
