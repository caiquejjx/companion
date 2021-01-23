defmodule Companion.Repo.Migrations.CreateCheckins do
  use Ecto.Migration

  def change do
    create table(:checkins) do
      add :date, :date
      add :complete, :boolean, default: true, null: false
      add :goal_id, references(:goals, on_delete: :delete_all)

      timestamps()
    end

    create index(:checkins, [:goal_id])
  end
end
