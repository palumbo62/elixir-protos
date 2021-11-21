defmodule ExerciseWeb.EmployeeControllerTest do
  use ExerciseWeb.ConnCase

  alias Exercise.Employees
  alias Exercise.Employees.Employee

  @create_attrs %{
    country_id: 2,
    currency_id: 2,
    full_name: "some full_name",
    job_titile: "some job_titile",
    salary: "120.5",
    string: "some string"
  }
  @update_attrs %{
    country_id: 3,
    currency_id: 433,
    full_name: "some updated full_name",
    job_titile: "some updated job_titile",
    salary: "456.7",
    string: "some updated string"
  }
  @invalid_attrs %{country_id: nil, currency_id: nil, full_name: nil, job_titile: nil, salary: nil, string: nil}

  def fixture(:employee) do
    {:ok, employee} = Employees.create_employee(@create_attrs)
    employee
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all employees", %{conn: conn} do
      conn = get(conn, Routes.employee_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create employee" do
    test "renders employee when data is valid", %{conn: conn} do
      conn = post(conn, Routes.employee_path(conn, :create), employee: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "country_id" => 2,
               "currency_id" => 2,
               "full_name" => "some full_name",
               "job_titile" => "some job_titile",
               "salary" => "120.5",
               "string" => "some string"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.employee_path(conn, :create), employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employee" do
    setup [:create_employee]

    test "renders employee when data is valid", %{conn: conn, employee: %Employee{id: id} = employee} do
      conn = put(conn, Routes.employee_path(conn, :update, employee), employee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "country_id" => 3,
               "currency_id" => 3,
               "full_name" => "some updated full_name",
               "job_titile" => "some updated job_titile",
               "salary" => "456.7",
               "string" => "some updated string"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employee: employee} do
      conn = put(conn, Routes.employee_path(conn, :update, employee), employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employee" do
    setup [:create_employee]

    test "deletes chosen employee", %{conn: conn, employee: employee} do
      conn = delete(conn, Routes.employee_path(conn, :delete, employee))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.employee_path(conn, :show, employee))
      end
    end
  end

  defp create_employee(_) do
    employee = fixture(:employee)
    %{employee: employee}
  end
end
