defmodule KuroCamsWeb.RoomChannelTest do
  use KuroCamsWeb.ChannelCase

  setup do
    room = KuroCams.ChatsFixtures.room_fixture()

    {:ok, _, socket} =
      KuroCamsWeb.ChatSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(KuroCamsWeb.RoomChannel, "room:1-2")

    %{socket: socket, room: room}
  end

  test "new_msg broadcasts to room:1-2", %{socket: socket, room: room} do
    push(socket, "new_msg", %{
      "body" => "hello",
      "user" => "#{room.from_user}",
      "uuid" => "#{room.uuid}"
    })

    assert_broadcast "new_msg", %{"body" => "hello"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"body" => "hello"})
    assert_push "broadcast", %{"body" => "hello"}
  end
end
