defmodule ExerciseWeb.EmployeeControllerTest do
  use ExerciseWeb.ConnCase

  alias Exercise.Employees
  alias Exercise.Employees.Employee

  @create_attrs %{
    country_id: 2,
    currency_id: 2,
    first_name: "some first name",
    last_name: "some last name",
    emp_id: 100,
    job_title: "some job_title",
    salary: 120.5
  }
  @update_attrs %{
    country_id: 3,
    currency_id: 3,
    first_name: "some updated first_name",
    last_name: "some last name",
    emp_id: 200,
    job_title: "some updated job_title",
    salary: 1456.7
  }
  @invalid_attrs %{
    country_id: nil, 
    currency_id: nil, 
    first_name: nil, 
    last_name: nil, 
    emp_id: nil,
    job_title: nil, 
    salary: nil
  }

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
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "emp_id" => 100,
               "job_title" => "some job_title",
               "salary" => 120.5
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

      IO.inspect(json_response(conn, 200)["data"])
      
      assert %{
               "id" => id,
               "country_id" => 3,
               "currency_id" => 3,
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "emp_id" => 200,
               "job_title" => "some updated job_title",
               "salary" => 1456.7
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
