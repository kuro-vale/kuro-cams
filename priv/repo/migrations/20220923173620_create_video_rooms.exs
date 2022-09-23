defmodule KuroCams.Repo.Migrations.CreateVideoRooms do
  use Ecto.Migration

  def change do
    create table(:video_rooms) do
      add :uuid, :uuid
      add :room_id, references(:rooms, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:video_rooms, [:uuid])
    create index(:video_rooms, [:room_id])
  end
end
