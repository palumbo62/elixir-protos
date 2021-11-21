defmodule ExerciseWeb.SalaryJobtitleControllerTest do
  use ExerciseWeb.ConnCase

  alias Exercise.Metrics
  alias Exercise.Metrics.SalaryJobtitle

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all salary_jobtitles", %{conn: conn} do
      conn = get(conn, Routes.salary_jobtitle_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
