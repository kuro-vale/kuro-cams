defmodule KuroCamsWeb.RoomChannel do
  @moduledoc """
  Chat rooms will save messages in database for both users
  """
  use KuroCamsWeb, :channel

  alias KuroCams.Chats
  alias KuroCamsWeb.Presence

  @impl true
  def join("room:lobby", _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  @impl true
  def join("room:" <> private_room_id, _payload, socket) do
    if authorized?(socket, private_room_id) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_in("new_msg", payload, socket) do
    pair_rooms = Chats.get_pair_rooms_by_uuid(payload["uuid"])

    IO.puts(length(pair_rooms))

    pair_rooms =
      if length(pair_rooms) == 1 do
        new_room = %{
          uuid: Ecto.UUID.generate(),
          from_user: Enum.at(pair_rooms, 0).to_user,
          to_user: payload["user"]
        }

        case Chats.create_room(new_room) do
          {:ok, room} ->
            Enum.concat(pair_rooms, [room])
        end
      else
        pair_rooms
      end

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

  @impl true
  def handle_info(:after_join, socket) do
    {:ok, _} =
      Presence.track(socket, "#{socket.assigns.current_user}", %{
        online_at: inspect(System.system_time(:second))
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end

  defp authorized?(socket, private_room_id) do
    private_room_id =~ "#{socket.assigns.current_user}"
  end
end
