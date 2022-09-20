defmodule KuroCamsWeb.ChatControllerTest do
  use KuroCamsWeb.ConnCase

  setup :register_and_log_in_user

  describe "GET /chats/:uuid" do
    test "renders chat page", %{conn: conn} do
      room = KuroCams.ChatsFixtures.room_fixture()
      conn = get(conn, Routes.chat_path(conn, :show, room.uuid))
      response = html_response(conn, 200)
      assert response =~ "Cards</h2>"
    end

    test "redirects if user is not logged in" do
      room = KuroCams.ChatsFixtures.room_fixture()
      conn = build_conn()
      conn = get(conn, Routes.chat_path(conn, :show, room.uuid))
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end
  end

  describe "POST /chats" do
    test "redirects to show when data is valid", %{conn: conn} do
      new_user = KuroCams.AccountsFixtures.user_fixture()
      to_user = %{id: new_user.id}
      conn = post(conn, Routes.chat_path(conn, :create), to_user: to_user)

      assert %{uuid: uuid} = redirected_params(conn)
      assert redirected_to(conn) == Routes.chat_path(conn, :show, uuid)

      conn = get(conn, Routes.chat_path(conn, :show, uuid))
      assert html_response(conn, 200) =~ "Cards</h2>"
    end

    test "redirect to home when data is invalid", %{conn: conn, user: logged_user} do
      conn = post(conn, Routes.chat_path(conn, :create), to_user: %{id: logged_user.id})
      assert redirected_to(conn) == Routes.home_path(conn, :index)
    end

    test "redirects if user is not logged in" do
      new_user = KuroCams.AccountsFixtures.user_fixture()
      to_user = %{id: new_user.id}
      conn = build_conn()
      conn = post(conn, Routes.chat_path(conn, :create), to_user: to_user)
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end
  end
end
