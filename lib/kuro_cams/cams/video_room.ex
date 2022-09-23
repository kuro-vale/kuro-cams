defmodule KuroCams.Cams.VideoRoom do
  @moduledoc """
  Video rooms where users can chat with webcams
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "video_rooms" do
    field :uuid, Ecto.UUID

    belongs_to :room, KuroCams.Chats.Room

    timestamps()
  end

  @doc false
  def changeset(video_room, attrs) do
    video_room
    |> cast(attrs, [:uuid, :room_id])
    |> validate_required([:uuid, :room_id])
    |> unique_constraint(:uuid)
  end
end
