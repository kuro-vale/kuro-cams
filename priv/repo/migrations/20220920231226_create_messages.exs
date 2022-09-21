defmodule KuroCams.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text, null: false
      add :room, references(:rooms, on_delete: :delete_all), null: false
      add :user, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:messages, [:room])
    create index(:messages, [:user])
  end
end
