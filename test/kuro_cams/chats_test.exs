defmodule KuroCams.ChatsTest do
  use KuroCams.DataCase

  alias KuroCams.Chats

  describe "rooms" do
    alias KuroCams.Chats.Room

    import KuroCams.ChatsFixtures
    import KuroCams.AccountsFixtures

    @invalid_attrs %{uuid: nil}

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Chats.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Chats.get_room!(room.id) == room
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

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      update_attrs = %{uuid: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Room{} = room} = Chats.update_room(room, update_attrs)
      assert room.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_room(room, @invalid_attrs)
      assert room == Chats.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Chats.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Chats.change_room(room)
    end
  end
end
