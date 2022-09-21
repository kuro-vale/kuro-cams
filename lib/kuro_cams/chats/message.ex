defmodule KuroCams.Chats.Message do
  @moduledoc """
  Messages stored in chat rooms
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    field :room, :id
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :room, :user])
    |> validate_required([:body, :room, :user])
  end
end
