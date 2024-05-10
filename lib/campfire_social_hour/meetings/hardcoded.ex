defmodule CampfireSocialHour.Meetings.Hardcoded do
  @moduledoc false
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "The TAP Room",
        id: 82_162_938_948,
        link: "https://westarete.zoom.us/j/82162938948?pwd=S3RoQW01ek1HM1RFbHIyWUgyRi9xdz09",
        img_name: "CAMPFire_TAPRoom.png"
      },
      %Meeting{
        topic: "IAM Navigators",
        id: 85_188_826_441,
        link: "https://westarete.zoom.us/j/85188826441?pwd=NjR3dGFGczZoQ0h5dlA0WGsyTDRpdz09",
        img_name: "CAMPFire_Navigator.png"
      },
      %Meeting{
        topic: "Ghost Stories",
        id: 81_469_598_503,
        link: "https://westarete.zoom.us/j/81469598503?pwd=M3Y1M1dXUHFkdHRhOENnQStLSHNiUT09",
        img_name: "CAMPFire_GhostStory.png"
      },
      %Meeting{
        topic: "Camp Fire Clairvoyance",
        id: 82_951_060_700,
        link: "https://westarete.zoom.us/j/82951060700?pwd=a2ZQUWNHbGpTejY0K1NmNzN1NjZ3Zz09",
        img_name: "CAMPFire_CrystalBall.png"
      },
      %Meeting{
        topic: "Let's Talk S'More - 1",
        id: 85_122_377_210,
        link: "https://westarete.zoom.us/j/85122377210?pwd=RTA5TWk1aUZHWkt5TG9PYlRGM1NwQT09",
        img_name: "CAMPFire_Smore.png"
      },
      %Meeting{
        topic: "Let's Talk S'More - 2",
        id: 86_768_169_687,
        link: "https://westarete.zoom.us/j/86768169687?pwd=SGNqSk5RR3ZBTG1nY2o2U1NuUXNLdz09",
        img_name: "CAMPFire_Smore.png"
      },
      %Meeting{
        topic: "Let's Talk S'More - 3",
        id: 82_016_201_416,
        link: "https://westarete.zoom.us/j/82016201416?pwd=YkVCbmROQk9UMndzc2tWNm9oQ2JMQT09",
        img_name: "CAMPFire_Smore.png"
      },
      %Meeting{
        topic: "Let's Talk S'More - 4",
        id: 82_924_055_582,
        link: "https://westarete.zoom.us/j/82924055582?pwd=VExYbHlGMDB4WXl0cG1YQy81dmRzZz09",
        img_name: "CAMPFire_Smore.png"
      }
    ]
  end
end
