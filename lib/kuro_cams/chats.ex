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
  If user A wants to chat with user B, will create a room from A to B, and user B will create a room from B to A
  This methods get that pair of rooms
  """
  def get_pair_rooms_by_uuid(uuid) do
    room = get_room_by_uuid!(uuid)

    supplier_query =
      from r in Room, where: r.from_user == ^room.to_user and r.to_user == ^room.from_user

    query =
      from r in Room,
        where: r.from_user == ^room.from_user and r.to_user == ^room.to_user,
        union: ^supplier_query

    Repo.all(query)
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

  alias KuroCams.Chats.Message

  def list_room_messages(room_id) do
    Repo.all(from m in Message, where: m.room == ^room_id)
  end

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end
end
