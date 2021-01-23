defmodule CompanionWeb.GoalView do
  use CompanionWeb, :view

  def get_percentage(length, objective) do
    length * 100 / objective
  end
end
