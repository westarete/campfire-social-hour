defmodule CampfireSocialHour.Meetings.Hardcoded do
  alias CampfireSocialHour.Meetings.Meeting

  def list_meetings() do
    [
      %Meeting{
        topic: "Abisko",
        id: 9_562_130_350,
        link: "https://us02web.zoom.us/j/9562130350?pwd=czJDMlg2MTA2RjUrdElDV0NIRS85QT09"
      },
      %Meeting{
        topic: "Banff",
        id: 86_528_458_980,
        link: "https://us02web.zoom.us/j/86528458980?pwd=WjhxYThyd2hKdkQyWXlTaEkwdG1mQT09"
      },
      %Meeting{
        topic: "Burren",
        id: 8_844_261_989,
        link: "https://us02web.zoom.us/j/8844261989?pwd=dmU4NmxhQzJaS3Yvc3M3cUcwODhBQT09"
      },
      %Meeting{
        topic: "Denali",
        id: 83_150_239_580,
        link: "https://us02web.zoom.us/j/83150239580?pwd=TndmeWE0RmhCLzFVRGwzblRVMzZaZz09"
      },
      %Meeting{
        topic: "Glacier",
        id: 7_180_501_831,
        link: "https://us02web.zoom.us/j/7180501831?pwd=ZkNnc3NFV0VrSmRIenhZSzAyRzV6Zz09"
      },
      %Meeting{
        topic: "Jasmund",
        id: 83_406_089_873,
        link: "https://us02web.zoom.us/j/83406089873?pwd=TXJwR3M0cnJsZWkvcFEyaEZUZHgzdz09"
      },
      %Meeting{
        topic: "Kruger",
        id: 2_860_071_973,
        link: "https://us02web.zoom.us/j/2860071973?pwd=WU8rL1V0ak4xOUpScTk4STFpSU1WQT09"
      },
      %Meeting{
        topic: "Rondane",
        id: 82_523_001_073,
        link: "https://us02web.zoom.us/j/82523001073?pwd=ZlRtcHBYY0lwUDV0NEpIcWFLUzE4UT09"
      },
      %Meeting{
        topic: "Snowdonia",
        id: 2_832_857_344,
        link: "https://us02web.zoom.us/j/2832857344?pwd=c20vQlpjb0gwbHZBSHUrSXF4Mk10QT09"
      },
      %Meeting{
        topic: "Sumava",
        id: 85_230_728_496,
        link: "https://us02web.zoom.us/j/85230728496?pwd=YnNTRmRHTGo0UlZ4Q3VZNXRkbzM4UT09"
      },
      %Meeting{
        topic: "Swiss",
        id: 8_897_037_919,
        link: "https://us02web.zoom.us/j/8897037919?pwd=WHhzakNlNDQ2ejl3Y09pRzRxQ0ZzZz09"
      },
      %Meeting{
        topic: "Yosemite",
        id: 86_150_137_083,
        link: "https://us02web.zoom.us/j/86150137083?pwd=YUs5c01XZW5Uc2ovUndLQjhya1drdz09"
      }
    ]
  end
end
