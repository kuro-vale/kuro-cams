defmodule KuroCams.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :uuid, :uuid
      add :from_user, references(:users, on_delete: :nothing)
      add :to_user, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:rooms, [:uuid])
    create index(:rooms, [:from_user])
    create index(:rooms, [:to_user])
  end
end
