defmodule KuroCams.ChatsTest do
  use KuroCams.DataCase

  alias KuroCams.Chats

  describe "rooms" do
    alias KuroCams.Chats.Room

    import KuroCams.ChatsFixtures
    import KuroCams.AccountsFixtures

    @invalid_attrs %{uuid: nil}

    test "get_rooms_by_user/1 returns user's rooms" do
      room = room_fixture()
      assert Chats.get_rooms_by_user(room.from_user) == [room]
    end

    test "get_room_by_from_user_and_to_user/1 returns the room with given ids" do
      room = room_fixture()
      assert Chats.get_room_by_from_user_and_to_user(room.from_user, room.to_user) == room
    end

    test "get_room_by_uuid!/1 returns the room with given uuid" do
      room = room_fixture()
      assert Chats.get_room_by_uuid!(room.uuid) == room
    end

    test "create_room/1 with valid data creates a room" do
      from_user = user_fixture()
      to_user = user_fixture()
      valid_attrs = %{uuid: "7488a646-e31f-11e4-aace-600308960662", from_user: from_user.id, to_user: to_user.id}

      assert {:ok, %Room{} = room} = Chats.create_room(valid_attrs)
      assert room.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_room(@invalid_attrs)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Chats.delete_room(room)
      assert nil == Chats.get_room_by_uuid!(room.uuid)
    end
  end
end
