defmodule KuroCams.Cams do
  @moduledoc """
  The Cams context.
  """

  import Ecto.Query, warn: false
  alias KuroCams.Repo

  alias KuroCams.Cams.VideoRoom

  def get_video_room_by_uuid(uuid), do: Repo.get_by(VideoRoom, uuid: uuid)

  def get_existing_video_room(uuid) do
    pair_rooms = KuroCams.Chats.get_pair_rooms_by_uuid(uuid)

    video_room =
      for room <- pair_rooms do
        if video_room = Repo.get_by(VideoRoom, room_id: room.id) do
          video_room
        end
      end

    List.first(video_room)
  end

  @doc """
  Creates a video_room.

  ## Examples

      iex> create_video_room(%{field: value})
      {:ok, %VideoRoom{}}

      iex> create_video_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video_room(attrs \\ %{}) do
    %VideoRoom{}
    |> VideoRoom.changeset(attrs)
    |> Repo.insert()
  end
end
