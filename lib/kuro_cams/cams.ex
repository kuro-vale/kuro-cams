defmodule KuroCams.Cams do
  @moduledoc """
  The Cams context.
  """

  import Ecto.Query, warn: false
  alias KuroCams.Repo

  alias KuroCams.Cams.VideoRoom

  def get_video_room_by_uuid(uuid), do: Repo.get_by(VideoRoom, uuid: uuid)

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
