defmodule Companion.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :title, :string
      add :current_streak, :integer, default: 0
      add :objective, :integer
      add :unit, :string

      timestamps()
    end

  end
end
