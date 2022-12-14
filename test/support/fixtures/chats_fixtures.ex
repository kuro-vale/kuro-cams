defmodule KuroCams.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KuroCams.Chats` context.
  """

  @doc """
  Generate a unique room uuid.
  """
  def unique_room_uuid do
    Ecto.UUID.generate()
  end

  def unique_user_id do
    user = KuroCams.AccountsFixtures.user_fixture()
    user.id
  end

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{
        uuid: unique_room_uuid(),
        from_user: unique_user_id(),
        to_user: unique_user_id()
      })
      |> KuroCams.Chats.create_room()

    room
  end

  def unique_room_id do
    room = room_fixture()
    room.id
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body",
        room: unique_room_id(),
        user: unique_user_id()
      })
      |> KuroCams.Chats.create_message()

    message
  end
end
