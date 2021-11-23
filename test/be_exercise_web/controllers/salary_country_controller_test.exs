defmodule ExerciseWeb.SalaryCountryControllerTest do
  use ExerciseWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all salary_countries", %{conn: conn} do
      conn = get(conn, Routes.salary_country_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
