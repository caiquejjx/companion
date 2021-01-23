defmodule Companion.Core.Goal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "goals" do
    field :objective, :integer
    field :title, :string
    field :unit, :string
    field :current_streak, :integer, default: 0
    has_many :checkins, Companion.Core.Checkin

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title, :objective, :unit, :current_streak])
    |> validate_required([:title, :objective, :unit])
  end
end
