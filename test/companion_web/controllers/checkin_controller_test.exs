defmodule CompanionWeb.CheckinControllerTest do
  use CompanionWeb.ConnCase

  alias Companion.Core

  @create_attrs %{complete: true, date: ~D[2010-04-17]}
  @update_attrs %{complete: false, date: ~D[2011-05-18]}
  @invalid_attrs %{complete: nil, date: nil}

  def fixture(:checkin) do
    {:ok, checkin} = Core.create_checkin(@create_attrs)
    checkin
  end

  describe "index" do
    test "lists all checkins", %{conn: conn} do
      conn = get(conn, Routes.checkin_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Checkins"
    end
  end

  describe "new checkin" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.checkin_path(conn, :new))
      assert html_response(conn, 200) =~ "New Checkin"
    end
  end

  describe "create checkin" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.checkin_path(conn, :create), checkin: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.checkin_path(conn, :show, id)

      conn = get(conn, Routes.checkin_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Checkin"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.checkin_path(conn, :create), checkin: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Checkin"
    end
  end

  describe "edit checkin" do
    setup [:create_checkin]

    test "renders form for editing chosen checkin", %{conn: conn, checkin: checkin} do
      conn = get(conn, Routes.checkin_path(conn, :edit, checkin))
      assert html_response(conn, 200) =~ "Edit Checkin"
    end
  end

  describe "update checkin" do
    setup [:create_checkin]

    test "redirects when data is valid", %{conn: conn, checkin: checkin} do
      conn = put(conn, Routes.checkin_path(conn, :update, checkin), checkin: @update_attrs)
      assert redirected_to(conn) == Routes.checkin_path(conn, :show, checkin)

      conn = get(conn, Routes.checkin_path(conn, :show, checkin))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, checkin: checkin} do
      conn = put(conn, Routes.checkin_path(conn, :update, checkin), checkin: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Checkin"
    end
  end

  describe "delete checkin" do
    setup [:create_checkin]

    test "deletes chosen checkin", %{conn: conn, checkin: checkin} do
      conn = delete(conn, Routes.checkin_path(conn, :delete, checkin))
      assert redirected_to(conn) == Routes.checkin_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.checkin_path(conn, :show, checkin))
      end
    end
  end

  defp create_checkin(_) do
    checkin = fixture(:checkin)
    %{checkin: checkin}
  end
end
