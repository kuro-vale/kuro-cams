defmodule KuroCamsWeb.RoomChannelTest do
  use KuroCamsWeb.ChannelCase

  setup do
    user = KuroCams.AccountsFixtures.user_fixture()
    to_user = KuroCams.AccountsFixtures.user_fixture()
    room = KuroCams.ChatsFixtures.room_fixture(from_user: user.id, to_user: to_user.id)

    {:ok, _, socket} =
      KuroCamsWeb.ChatSocket
      |> socket("user_id", %{current_user: user.id})
      |> subscribe_and_join(KuroCamsWeb.RoomChannel, "room:#{user.id}-#{to_user.id}")

    %{socket: socket, room: room}
  end

  test "new_msg broadcasts to private room", %{socket: socket, room: room} do
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

  test "error on connecting to private room" do
    from_user = KuroCams.AccountsFixtures.user_fixture()
    to_user = KuroCams.AccountsFixtures.user_fixture()
    unauthorized_user = KuroCams.AccountsFixtures.user_fixture()

    assert {:error, _} =
             KuroCamsWeb.ChatSocket
             |> socket("user_id", %{current_user: unauthorized_user.id})
             |> subscribe_and_join(KuroCamsWeb.RoomChannel, "room:#{from_user.id}-#{to_user.id}")
  end
end
