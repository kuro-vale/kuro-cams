defmodule KuroCamsWeb.UserRegistrationControllerTest do
  use KuroCamsWeb.ConnCase, async: true

  import KuroCams.AccountsFixtures

  describe "GET /users/register" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, Routes.user_registration_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "Register</h2>"
    end

    test "redirects if already logged in", %{conn: conn} do
      conn = conn |> log_in_user(user_fixture()) |> get(Routes.user_registration_path(conn, :new))
      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /users/register" do
    @tag :capture_log
    test "creates account and logs the user in", %{conn: conn} do
      username = unique_user_username()

      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => valid_user_attributes(username: username)
        })

      assert get_session(conn, :user_token)
      assert redirected_to(conn) == "/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ username
      assert response =~ "Chats"
      assert response =~ "Home"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.user_registration_path(conn, :create), %{
          "user" => %{"username" => "n n", "password" => "1"}
        })

      response = html_response(conn, 200)
      assert response =~ "Register</h2>"
      assert response =~ "must be a valid username"
      assert response =~ "should be at least 3 character"
    end
  end
end
