defmodule KuroCamsWeb.MessageController do
  use KuroCamsWeb, :controller

  alias KuroCams.Chats

  # Temporal method, implementations must be done in channels

  def create(conn,  %{"uuid" => uuid, "message_body" => message_body}) do
    pair_rooms = Chats.get_pair_rooms_by_uuid(uuid)
    for room <- pair_rooms do
      Chats.create_message(%{body: message_body["body"], room: room.id, user: conn.assigns.current_user.id})
    end
    conn
    |> redirect(to: Routes.home_path(conn, :index))
  end
end
