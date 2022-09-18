defmodule KuroCamsWeb.UserSettingsControllerTest do
  use KuroCamsWeb.ConnCase, async: true

  setup :register_and_log_in_user

  describe "GET /users/settings" do
    test "renders settings page", %{conn: conn} do
      conn = get(conn, Routes.user_settings_path(conn, :edit))
      response = html_response(conn, 200)
      assert response =~ "Profile</h2>"
    end

    test "raise error if user is not logged in" do
      conn = build_conn()
      assert_raise KuroCamsWeb.Unauthorized, fn ->
        get(conn, Routes.user_settings_path(conn, :edit))
      end
    end
  end
end
