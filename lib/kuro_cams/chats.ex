defmodule KuroCams.Chats do
  @moduledoc """
  The Chats context.
  """

  import Ecto.Query, warn: false
  alias KuroCams.Repo

  alias KuroCams.Chats.Room

  def get_rooms_by_user(user_id) do
    Repo.all(from r in Room, where: r.from_user == ^user_id)
  end

  def get_room_by_uuid!(uuid), do: Repo.get_by(Room, uuid: uuid)

  def get_room_by_from_user_and_to_user(from_user, to_user) do
    Repo.get_by(Room, from_user: from_user, to_user: to_user)
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end
end
