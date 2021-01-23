defmodule Companion.Core.Checkin do
  use Ecto.Schema
  import Ecto.Changeset

  schema "checkins" do
    field :complete, :boolean, default: true
    field :date, :date
    belongs_to :goal, Companion.Core.Goal

    timestamps()
  end

  @doc false
  def changeset(checkin, attrs) do
    checkin
    |> cast(attrs, [:date, :goal_id])
    |> validate_required([:date, :goal_id])
  end
end
