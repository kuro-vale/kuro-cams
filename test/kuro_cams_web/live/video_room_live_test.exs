defmodule KuroCamsWeb.VideoRoomLiveTest do
  use KuroCamsWeb.ConnCase

  import Phoenix.LiveViewTest
  import KuroCams.CamsFixtures
  import KuroCams.ChatsFixtures

  setup :register_and_log_in_user

  describe "Show" do
    test "displays video_room", %{conn: conn, user: logged_user} do
      room = room_fixture(from_user: logged_user.id)
      video_room = video_room_fixture(room_id: room.id)

      {:ok, _show_live, html} =
        live(conn, Routes.video_room_show_path(conn, :show, video_room.uuid))

      assert html =~ "<button id=\"join-call\""
    end

    test "raise error if user is unauthorized", %{conn: conn} do
      video_room = video_room_fixture()

      assert_raise KuroCamsWeb.ForbiddenError, fn ->
        live(conn, Routes.video_room_show_path(conn, :show, video_room.uuid))
      end
    end
  end
end
