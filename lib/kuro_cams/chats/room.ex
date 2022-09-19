defmodule KuroCams.Chats.Room do
  @moduledoc """
  Rooms to sends messages between two users
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :uuid, Ecto.UUID
    field :from_user, :id
    field :to_user, :id

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:uuid, :from_user, :to_user])
    |> validate_required([:uuid, :from_user, :to_user])
    |> unique_constraint(:uuid)
  end
end
