defmodule KuroCamsWeb.ChatController do
  use KuroCamsWeb, :controller

  alias KuroCams.Chats

  def create(conn, %{"to_user" => to_user}) do
    logged_user_id = conn.assigns.current_user.id
    existing_room = Chats.get_room_by_from_user_and_to_user(logged_user_id, to_user["id"])

    if existing_room do
      conn
      |> redirect(to: Routes.chat_path(conn, :show, existing_room.uuid))
    else
      new_room = %{uuid: Ecto.UUID.generate(), from_user: logged_user_id, to_user: to_user["id"]}

      case Chats.create_room(new_room) do
        {:ok, room} ->
          conn
          |> redirect(to: Routes.chat_path(conn, :show, room.uuid))

        {:error, %Ecto.Changeset{}} ->
          conn
          |> redirect(to: Routes.home_path(conn, :index))
      end
    end
  end

  def show(conn, %{"uuid" => uuid}) do
    room =
      uuid
      |> Chats.get_room_by_uuid!()

    if room == nil do
      raise KuroCamsWeb.NotFoundError, "Not Found"
    end

    room_messages = Chats.list_room_messages(room.id)

    render(conn, "show.html", room: room, messages: room_messages)
  end

  def delete(conn, %{"uuid" => uuid}) do
    room = Chats.get_room_by_uuid!(uuid)
    {:ok, _room} = Chats.delete_room(room)

    conn
    |> redirect(to: Routes.home_path(conn, :index))
  end
end
