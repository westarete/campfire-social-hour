defmodule CampfireSocialHour.ZoomCredentialAgentTest do
  # Note: async: false is necessary because we're modifying the application environment
  use ExUnit.Case, async: false

  alias CampfireSocialHour.ZoomCredentialAgent

  setup do
    put_env(:campfire_social_hour, :zoom_api, CampfireSocialHour.ZoomApiMock)
    # Mox.stub_with(CampfireSocialHour.ZoomApiMock, CampfireSocialHour.ZoomApiStub)
    :ok
  end

  describe "access_token/0" do
    test "when zoom api returns a valid response", %{test: test} do
      Mox.stub(CampfireSocialHour.ZoomApiMock, :get_access_token, fn ->
        {:ok, %{access_token: "fauxtoken", expires_in: 5 * 60}}
      end)

      pid =
        start_supervised!({ZoomCredentialAgent, name: test, initial_state: %{access_token: nil}})

      Mox.allow(CampfireSocialHour.ZoomApiMock, self(), pid)

      assert ZoomCredentialAgent.access_token(pid) == "fauxtoken"
    end

    test "when zoom api barfs", %{test: test} do
      Mox.stub(CampfireSocialHour.ZoomApiMock, :get_access_token, fn -> :error end)

      Process.flag(:trap_exit, true)

      pid =
        start_supervised!({ZoomCredentialAgent, name: test, initial_state: %{access_token: nil}})

      Mox.allow(CampfireSocialHour.ZoomApiMock, self(), pid)

      error =
        catch_exit do
          ZoomCredentialAgent.access_token(test)
        end

      assert {{{:case_clause, :error}, _}, _} = error
    end
  end

  defp put_env(app, key, value) do
    previous_value = Application.get_env(app, key)
    Application.put_env(app, key, value)
    on_exit(fn -> Application.put_env(app, key, previous_value) end)
  end
end
