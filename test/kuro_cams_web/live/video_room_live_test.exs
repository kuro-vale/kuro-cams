defmodule KuroCamsWeb.VideoRoomLiveTest do
  use KuroCamsWeb.ConnCase

  import Phoenix.LiveViewTest
  import KuroCams.CamsFixtures

  setup :register_and_log_in_user
  
  defp create_video_room(_) do
    video_room = video_room_fixture()
    %{video_room: video_room}
  end

  describe "Show" do
    setup [:create_video_room]

    test "displays video_room", %{conn: conn, video_room: video_room} do
      {:ok, _show_live, html} = live(conn, Routes.video_room_show_path(conn, :show, video_room.uuid))

      assert html =~ "Show Video room"
    end
  end
end
