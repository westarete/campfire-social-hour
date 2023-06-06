defmodule CampfireSocialHour.ZoomCredentialAgentTest do
  use CampfireSocialHour.ZoomApiCase, async: false

  alias CampfireSocialHour.ZoomCredentialAgent

  describe "access_token/0" do
    test "when zoom api returns a valid response" do
      assert ZoomCredentialAgent.access_token() == "abc123"
    end

    test "when zoom api barfs" do
      Mox.stub(CampfireSocialHour.ZoomApiMock, :get_access_token, fn -> :error end)
      assert ZoomCredentialAgent.access_token() == nil
    end
  end
end
