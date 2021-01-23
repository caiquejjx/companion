defmodule Companion.CoreTest do
  use Companion.DataCase

  alias Companion.Core

  describe "goals" do
    alias Companion.Core.Goal

    @valid_attrs %{objective: 42, title: "some title", unit: "some unit"}
    @update_attrs %{objective: 43, title: "some updated title", unit: "some updated unit"}
    @invalid_attrs %{objective: nil, title: nil, unit: nil}

    def goal_fixture(attrs \\ %{}) do
      {:ok, goal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_goal()

      goal
    end

    test "list_goals/0 returns all goals" do
      goal = goal_fixture()
      assert Core.list_goals() == [goal]
    end

    test "get_goal!/1 returns the goal with given id" do
      goal = goal_fixture()
      assert Core.get_goal!(goal.id) == goal
    end

    test "create_goal/1 with valid data creates a goal" do
      assert {:ok, %Goal{} = goal} = Core.create_goal(@valid_attrs)
      assert goal.objective == 42
      assert goal.title == "some title"
      assert goal.unit == "some unit"
    end

    test "create_goal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_goal(@invalid_attrs)
    end

    test "update_goal/2 with valid data updates the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{} = goal} = Core.update_goal(goal, @update_attrs)
      assert goal.objective == 43
      assert goal.title == "some updated title"
      assert goal.unit == "some updated unit"
    end

    test "update_goal/2 with invalid data returns error changeset" do
      goal = goal_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_goal(goal, @invalid_attrs)
      assert goal == Core.get_goal!(goal.id)
    end

    test "delete_goal/1 deletes the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{}} = Core.delete_goal(goal)
      assert_raise Ecto.NoResultsError, fn -> Core.get_goal!(goal.id) end
    end

    test "change_goal/1 returns a goal changeset" do
      goal = goal_fixture()
      assert %Ecto.Changeset{} = Core.change_goal(goal)
    end
  end

  describe "streaks" do
    alias Companion.Core.Streak

    @valid_attrs %{length: 42}
    @update_attrs %{length: 43}
    @invalid_attrs %{length: nil}

    def streak_fixture(attrs \\ %{}) do
      {:ok, streak} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_streak()

      streak
    end

    test "list_streaks/0 returns all streaks" do
      streak = streak_fixture()
      assert Core.list_streaks() == [streak]
    end

    test "get_streak!/1 returns the streak with given id" do
      streak = streak_fixture()
      assert Core.get_streak!(streak.id) == streak
    end

    test "create_streak/1 with valid data creates a streak" do
      assert {:ok, %Streak{} = streak} = Core.create_streak(@valid_attrs)
      assert streak.length == 42
    end

    test "create_streak/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_streak(@invalid_attrs)
    end

    test "update_streak/2 with valid data updates the streak" do
      streak = streak_fixture()
      assert {:ok, %Streak{} = streak} = Core.update_streak(streak, @update_attrs)
      assert streak.length == 43
    end

    test "update_streak/2 with invalid data returns error changeset" do
      streak = streak_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_streak(streak, @invalid_attrs)
      assert streak == Core.get_streak!(streak.id)
    end

    test "delete_streak/1 deletes the streak" do
      streak = streak_fixture()
      assert {:ok, %Streak{}} = Core.delete_streak(streak)
      assert_raise Ecto.NoResultsError, fn -> Core.get_streak!(streak.id) end
    end

    test "change_streak/1 returns a streak changeset" do
      streak = streak_fixture()
      assert %Ecto.Changeset{} = Core.change_streak(streak)
    end
  end

  describe "checkins" do
    alias Companion.Core.Checkin

    @valid_attrs %{complete: true, date: ~D[2010-04-17]}
    @update_attrs %{complete: false, date: ~D[2011-05-18]}
    @invalid_attrs %{complete: nil, date: nil}

    def checkin_fixture(attrs \\ %{}) do
      {:ok, checkin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_checkin()

      checkin
    end

    test "list_checkins/0 returns all checkins" do
      checkin = checkin_fixture()
      assert Core.list_checkins() == [checkin]
    end

    test "get_checkin!/1 returns the checkin with given id" do
      checkin = checkin_fixture()
      assert Core.get_checkin!(checkin.id) == checkin
    end

    test "create_checkin/1 with valid data creates a checkin" do
      assert {:ok, %Checkin{} = checkin} = Core.create_checkin(@valid_attrs)
      assert checkin.complete == true
      assert checkin.date == ~D[2010-04-17]
    end

    test "create_checkin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_checkin(@invalid_attrs)
    end

    test "update_checkin/2 with valid data updates the checkin" do
      checkin = checkin_fixture()
      assert {:ok, %Checkin{} = checkin} = Core.update_checkin(checkin, @update_attrs)
      assert checkin.complete == false
      assert checkin.date == ~D[2011-05-18]
    end

    test "update_checkin/2 with invalid data returns error changeset" do
      checkin = checkin_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_checkin(checkin, @invalid_attrs)
      assert checkin == Core.get_checkin!(checkin.id)
    end

    test "delete_checkin/1 deletes the checkin" do
      checkin = checkin_fixture()
      assert {:ok, %Checkin{}} = Core.delete_checkin(checkin)
      assert_raise Ecto.NoResultsError, fn -> Core.get_checkin!(checkin.id) end
    end

    test "change_checkin/1 returns a checkin changeset" do
      checkin = checkin_fixture()
      assert %Ecto.Changeset{} = Core.change_checkin(checkin)
    end
  end
end
