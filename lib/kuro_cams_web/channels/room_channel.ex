defmodule KuroCamsWeb.RoomChannel do
  @moduledoc """
  Chat rooms will save messages in database for both users
  """
  use KuroCamsWeb, :channel

  alias KuroCams.Chats

  @impl true
  def join("room:" <> _private_room_id, _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("new_msg", payload, socket) do
    pair_rooms = Chats.get_pair_rooms_by_uuid(payload["uuid"])

    for room <- pair_rooms do
      Chats.create_message(%{
        body: payload["body"],
        room: room.id,
        user: payload["user"]
      })
    end

    broadcast(socket, "new_msg", payload)
    {:noreply, socket}
  end
end
