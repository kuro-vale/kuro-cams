defmodule KuroCams.CamsTest do
  use KuroCams.DataCase

  alias KuroCams.Cams

  describe "video_rooms" do
    alias KuroCams.Cams.VideoRoom

    import KuroCams.CamsFixtures

    @invalid_attrs %{uuid: nil}

    test "get_video_room_by_uuid/1 returns the video_room with given id" do
      video_room = video_room_fixture()
      assert Cams.get_video_room_by_uuid(video_room.uuid) == video_room
    end

    test "create_video_room/1 with valid data creates a video_room" do
      room = KuroCams.ChatsFixtures.room_fixture()
      valid_attrs = %{uuid: "7488a646-e31f-11e4-aace-600308960662", room_id: room.id}

      assert {:ok, %VideoRoom{} = video_room} = Cams.create_video_room(valid_attrs)
      assert video_room.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_video_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cams.create_video_room(@invalid_attrs)
    end
  end
end
