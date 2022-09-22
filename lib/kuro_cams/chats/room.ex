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
    |> validate_is_not_same_user()
  end

  defp validate_is_not_same_user(changeset) do
    from_user = get_field(changeset, :from_user)
    to_user = get_field(changeset, :to_user)

    if from_user == to_user do
      add_error(changeset, :to_user, "Cannot send messages to same user")
    else
      changeset
    end
  end
end
