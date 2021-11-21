defmodule Exercise.EmployeesTest do
  use Exercise.DataCase
 
  alias Exercise.Employees

  describe "employees" do
    alias Exercise.Employees.Employee
    alias Exercise.Countries

    @cntry_valid_attrs %{
      code: "some code", 
      name: "some name"
    }
    @valid_attrs %{
      country_id: 1, 
      first_name: "some first_name", 
      last_name: "some last_name", 
      job_title: "some job_title", 
      salary: 120.5,
      emp_id: 20000
    }

    @update_attrs %{
      country_id: 2, 
      first_name: "some updated first_name", 
      last_name: "some updated last_name", 
      job_title: "some updated job_title", 
      salary: 1456.7,
      emp_id: 20001
    }

    @invalid_attrs %{
      country_id: nil, 
      first_name: nil, 
      last_name: nil, 
      job_title: nil, 
      salary: nil,
      emp_id: nil
    }

    # def employee_fixture(attrs \\ %{}) do
    #   {:ok, country} =
    #     cntry_valid_attrs
    #     |> Enum.into(@cntry_attrs)
    #     |> Countries.create_country()
    #   Countries.get_country!(country.id)

    #   IO.inspect(country.id, label: "CNTRY ID: ")
    #   @valid_attrs Map.put(@valid_attrs, :country_id, country_id)
    #   IO.inspect(@valid_attrs, label: "EMP ATTRS: ")

     # {:ok, employee} =
     #   @valid_attrs
        #|> Enum.into(@valid_attrs)
        #|> Employees.create_employee!()

      #employee
   # end

    # test "list_employees/0 returns all employees" do
    #   employee = employee_fixture_2()
    #   #assert Employees.list_employees() == [employee]
    # end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      IO.inspect(employee, label: "GET: ")
      assert Employees.get_employee!(employee.id) == employee
    end

    # test "create_employee/1 with valid data creates a employee" do
    #   assert {:ok, %Employee{} = employee} = Employees.create_employee!(@valid_attrs)
    #   assert employee.country_id == 1
    #   assert employee.currency_id == 1
    #   assert employee.first_name == "some first_name"
    #   assert employee.last_name == "some last_name"
    #   assert employee.job_title == "some job_title"
    #   assert employee.salary == 120.5
    #   assert employee.emp_id == 100
    # end

    # test "create_employee/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Employees.create_employee!(@invalid_attrs)
    # end

    # test "update_employee/2 with valid data updates the employee" do
    #   employee = employee_fixture()
    #   assert {:ok, %Employee{} = employee} = Employees.update_employee!(employee, @update_attrs)
    #   assert employee.country_id == 2
    #   assert employee.currency_id == 2
    #   assert employee.first_name == "some updated first_name"
    #   assert employee.last_name == "some updated last_name"
    #   assert employee.job_title == "some updated job_title"
    #   assert employee.salary == 1456.7
    #   assert employee.emp_id == 200      
    # end

    # test "update_employee/2 with invalid data returns error changeset" do
    #   employee = employee_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Employees.update_employee!(employee, @invalid_attrs)
    #   assert employee == Employees.get_employee!(employee.id)
    # end

    # test "delete_employee/1 deletes the employee" do
    #   employee = employee_fixture()
    #   assert {:ok, %Employee{}} = Employees.delete_employee(employee)
    #   assert_raise Ecto.NoResultsError, fn -> Employees.get_employee!(employee.id) end
    # end

    # test "change_employee/1 returns a employee changeset" do
    #   employee = employee_fixture()
    #   assert %Ecto.Changeset{} = Employees.change_employee(employee)
    # end
  end
end
