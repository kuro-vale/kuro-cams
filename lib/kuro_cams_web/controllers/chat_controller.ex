defmodule KuroCamsWeb.ChatController do
  use KuroCamsWeb, :controller

  alias KuroCams.Chats

  def create(conn, %{"to_user" => to_user}) do
    new_room = %{uuid: Ecto.UUID.generate, from_user: conn.assigns.current_user.id, to_user: to_user["id"]}
    case Chats.create_room(new_room) do
      {:ok, room} ->
        conn
        |> redirect(to: Routes.chat_path(conn, :show, room.uuid))

      {:error, %Ecto.Changeset{}} ->
        conn
        |> redirect(to: Routes.home_path(conn, :index))
    end
  end

  def show(conn, %{"uuid" => uuid}) do
    room =
      uuid
      |> Chats.get_room_by_uuid!

    render(conn, "show.html", room: room)
  end
end
