defmodule CompanionWeb.CheckinController do
  use CompanionWeb, :controller

  alias Companion.Core
  alias Companion.Core.Checkin

  def index(conn, _params) do
    checkins = Core.list_checkins()
    render(conn, "index.html", checkins: checkins)
  end

  def new(conn, _params) do
    changeset = Core.change_checkin(%Checkin{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"checkin" => checkin_params}) do
    case Core.create_checkin(checkin_params) do
      {:ok, _checkin} ->
        conn
        |> put_flash(:info, "Checkin created successfully.")
        |> redirect(to: Routes.goal_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    checkin = Core.get_checkin!(id)
    render(conn, "show.html", checkin: checkin)
  end

  def edit(conn, %{"id" => id}) do
    checkin = Core.get_checkin!(id)
    changeset = Core.change_checkin(checkin)
    render(conn, "edit.html", checkin: checkin, changeset: changeset)
  end

  def update(conn, %{"id" => id, "checkin" => checkin_params}) do
    checkin = Core.get_checkin!(id)

    case Core.update_checkin(checkin, checkin_params) do
      {:ok, checkin} ->
        conn
        |> put_flash(:info, "Checkin updated successfully.")
        |> redirect(to: Routes.checkin_path(conn, :show, checkin))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", checkin: checkin, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    checkin = Core.get_checkin!(id)
    {:ok, _checkin} = Core.delete_checkin(checkin)

    conn
    |> put_flash(:info, "Checkin deleted successfully.")
    |> redirect(to: Routes.checkin_path(conn, :index))
  end
end
