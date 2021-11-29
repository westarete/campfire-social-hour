defmodule CampfireSocialHour.Meetings.Hardcoded do
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "Ashburn",
        id: 86_376_488_264,
        link: "https://us02web.zoom.us/j/86376488264?pwd=WmduUmdVZWxoTnZsaitWN002MkdHdz09"
      },
      %Meeting{
        topic: "Chicago",
        id: 83_621_026_805,
        link: "https://us02web.zoom.us/j/83621026805?pwd=RkxacmVUQlBpNE4zcUlqYUFRdzBlZz09"
      },
      %Meeting{
        topic: "Dallas",
        id: 88_662_029_375,
        link: "https://us02web.zoom.us/j/88662029375?pwd=aWR6alV3U2Joa21LN0NpdHEyZkNiQT09"
      },
      %Meeting{
        topic: "San Jose",
        id: 85_968_416_796,
        link: "https://us02web.zoom.us/j/85968416796?pwd=L2EycEp5aXh6eHRqOUw3YWpEcjUwQT09"
      },
      %Meeting{
        topic: "NYC",
        id: 85_407_580_723,
        link: "https://us02web.zoom.us/j/85407580723?pwd=aWFqQTR3Y3RpMDdMVGtzNS8vN05RUT09"
      },
      %Meeting{
        topic: "Seattle",
        id: 83_967_015_444,
        link: "https://us02web.zoom.us/j/83967015444?pwd=czl1MnVnTHRSdEJaa2JkQU5oUXhidz09"
      }
      # %Meeting{
      #   topic: "",
      #   id: 88278724058,
      #   link: "https://us02web.zoom.us/j/88278724058?pwd=enBIQkw2VHVTc2NJaXZ2bE9EODg3QT09"
      # },
      # %Meeting{
      #   topic: "",
      #   id: 85974105339,
      #   link: "https://us02web.zoom.us/j/85974105339?pwd=bUlXSmd4bVJFNmFPV0RrVEZ4QTBpdz09"
      # },
      # %Meeting{
      #   topic: "",
      #   id: 89994540216,
      #   link: "https://us02web.zoom.us/j/89994540216?pwd=VmhqTTFFc0hLN3VMZmttNWRXenNwUT09"
      # },
      # %Meeting{
      #   topic: "",
      #   id: 85731735895,
      #   link: "https://us02web.zoom.us/j/85731735895?pwd=Yk9tT2xERmQ2ejBobkxSREo0NFFVUT09"
      # },
      # %Meeting{
      #   topic: "",
      #   id: 83891028430,
      #   link: "https://us02web.zoom.us/j/83891028430?pwd=ZmtqdGJjM3U1WlVmeWJieGNGelZUUT09"
      # },
      # %Meeting{
      #   topic: "",
      #   id: 89916042904,
      #   link: "https://us02web.zoom.us/j/89916042904?pwd=K0JzK3F2Q3FQeHhXVTVscjBocVRhUT09"
      # }
    ]
  end
end
