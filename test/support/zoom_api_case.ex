defmodule CampfireSocialHour.ZoomApiCase do
  use ExUnit.CaseTemplate

  setup do
    Mox.stub_with(CampfireSocialHour.ZoomApiMock, CampfireSocialHour.ZoomApiStub)
    Mox.allow(CampfireSocialHour.ZoomApiMock, self(), CampfireSocialHour.ZoomCredentialAgent)
    :ok
  end
end
