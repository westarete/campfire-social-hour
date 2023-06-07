defmodule CampfireSocialHour.ZoomCredentialAgentTest do
  # use CampfireSocialHour.ZoomApiCase, async: false
  use ExUnit.Case, async: false

  alias CampfireSocialHour.ZoomCredentialAgent

  setup do
    Mox.stub_with(CampfireSocialHour.ZoomApiMock, CampfireSocialHour.ZoomApiStub)
    :ok
  end

  describe "access_token/0" do
    test "when zoom api returns a valid response", %{test: test} do
      pid = start_supervised!({ZoomCredentialAgent, name: test})
      Mox.allow(CampfireSocialHour.ZoomApiMock, self(), pid)
      assert ZoomCredentialAgent.access_token(test) == "abc123"
    end

    test "when zoom api barfs", %{test: test} do
      Mox.stub(CampfireSocialHour.ZoomApiMock, :get_access_token, fn -> :error end)

      Process.flag(:trap_exit, true)
      pid = start_supervised!({ZoomCredentialAgent, name: test})
      Mox.allow(CampfireSocialHour.ZoomApiMock, self(), pid)

      error =
        catch_exit do
          ZoomCredentialAgent.access_token(test)
        end

      assert {{{:case_clause, :error}, _}, _} = error
    end
  end
end
