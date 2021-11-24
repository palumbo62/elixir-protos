defmodule ExerciseWeb.EmployeeController do
  use ExerciseWeb, :controller

  alias Exercise.Employees
  alias Exercise.Employees.Employee

  action_fallback ExerciseWeb.FallbackController

  def index(conn, _params) do
    employees = Employees.list_employees()
    render(conn, "index.json", employees: employees)
  end

  def create(conn, %{"employee" => employee_params}) do
    with {:ok, %Employee{} = employee} <- Employees.create_employee(employee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.employee_path(conn, :show, employee))
      |> render("show.json", employee: employee)
    end
  end

  def show(conn, %{"id" => id}) do
    case Employees.get_employee(id) do
      nil -> {:error, :not_found}
      employee ->
        render(conn, "show.json", employee: employee)
    end
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    case Employees.get_employee(id) do
      nil -> {:error, :not_found}
      employee ->
        with {:ok, %Employee{} = employee} 
          <- Employees.update_employee(employee, employee_params) do
            render(conn, "show.json", employee: employee)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    case Employees.get_employee(id) do
      nil -> {:error, :not_found}
      employee ->
        with {:ok, %Employee{}} 
          <- Employees.delete_employee(employee) do
            send_resp(conn, :no_content, "")
        end
    end
  end

end
