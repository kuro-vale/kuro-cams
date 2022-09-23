defmodule KuroCams.CamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KuroCams.Cams` context.
  """

  @doc """
  Generate a unique video_room uuid.
  """
  def unique_video_room_uuid do
    Ecto.UUID.generate()
  end

  @doc """
  Generate a video_room.
  """
  def video_room_fixture(attrs \\ %{}) do
    {:ok, video_room} =
      attrs
      |> Enum.into(%{
        uuid: unique_video_room_uuid(),
        room_id: KuroCams.ChatsFixtures.room_fixture().id
      })
      |> KuroCams.Cams.create_video_room()

    video_room
  end
end
