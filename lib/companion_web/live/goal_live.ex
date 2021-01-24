defmodule CompanionWeb.GoalLive do
  use CompanionWeb, :live_view
  alias Companion.Core

  def get_percentage(length, objective) do
    length * 100 / objective
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, goals: Core.list_goals())}
  end

  def fetch(socket) do
    assign(socket, goals: Core.list_goals())
  end

  def handle_event(event, _) do
    IO.inspect(event)
  end

  def handle_event("addGoal", %{"goal" => goal}, socket) do
    Core.create_goal(goal)

    {:noreply, fetch(socket)}
  end

  def handle_event("addCheckin", %{"checkin" => checkin}, socket) do
    Core.create_checkin(checkin)

    {:noreply, fetch(socket)}
  end

  # def handle_event("validateGoal", %{"goal" => params}, socket) do
  #   changeset =
  #     %Goal{}
  #     |> Companion.Core.Goal.changeset(paramas)

  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  # def render(assigns) do
  #   ~L"Rendering"
  # end
end
