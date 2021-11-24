defmodule ExerciseWeb.EmployeeView do
  use ExerciseWeb, :view
  alias ExerciseWeb.EmployeeView

  def render("index.json", %{employees: employees}) do
    %{data: render_many(employees, EmployeeView, "employee.json")}
  end

  def render("show.json", %{employee: employee}) do
    %{data: render_one(employee, EmployeeView, "employee.json")}
  end

  def render("employee.json", %{employee: employee}) do
    %{id: employee.id,
      first_name: employee.first_name,
      last_name: employee.last_name,
      emp_id: employee.emp_id,
      job_title: employee.job_title,
      salary: Decimal.round(employee.salary, 2),
      country_id: employee.country_id}
  end
end
