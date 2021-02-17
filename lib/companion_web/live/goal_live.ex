defmodule CompanionWeb.GoalLive do
  use CompanionWeb, :live_view
  alias Companion.Core
  alias Companion.Core.Goal

  def get_percentage(length, objective) do
    length * 100 / objective
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Core.subscribe()
    {:ok, assign(socket, goals: Core.list_goals()), temporary_assigns: [goals: []]}
  end

  def fetch(socket) do
    assign(socket, goals: Core.list_goals())
  end

  @impl true
  def handle_event("addGoal", %{"goal" => goal}, socket) do
    Core.create_goal(goal)

    {:noreply, fetch(socket)}
  end

  @impl true
  def handle_event("addCheckin", %{"checkin" => checkin}, socket) do
    Core.create_checkin(checkin)

    {:noreply, fetch(socket)}
  end

  @impl true
  def handle_event("validate", %{"goal" => goal_params}, socket) do
    changeset =
      %Goal{}
      |> Goal.changeset(goal_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_info({:goal_created, goal}, socket) do
    {:noreply, update(socket, :goals, fn goals -> [goal | goals] end)}
  end

  def handle_info({:goal_updated, goal}, socket) do
    {:noreply, update(socket, :goals, fn goals -> [goal | goals] end)}
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
