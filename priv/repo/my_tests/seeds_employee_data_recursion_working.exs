# Module for populating the database with randomized
# employee data. You can run it as:
#
#     $elixir run priv/repo/seeds_employee_data.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Exercise.Repo.insert!(%Exercise.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
defmodule EmployeeData do
  alias EmployeeData
  alias Exercise.Countries

  # Function to generate the first_names file and build a list first names
  def generate_first_names do
    with {:ok, first_names} = File.read("./priv/data/first_names.txt") do 
        first_names
        |> String.split("\r\n", trim: true) 
        #|> IO.inspect
    end
  end

  # Function to generate the last_names file and build a list last names
  def generate_last_names do
     with {:ok, last_names} = File.read("./priv/data/last_names.txt") do 
      last_names
      |> String.split("\r\n", trim: true) 
      #|> IO.inspect
    end
  end

  # Function to generate the job_title file and build a list job titles
  def generate_job_titles do
    with {:ok, job_titles} = File.read("./priv/data/job_titles.txt") do 
      job_titles
      |> String.split("\r\n", trim: true) 
      #|> IO.inspect
    end
  end

  # Function to generate country and currencies to build a list of country and 
  # currency ids
  def generate_countries_currencies do
    # Get the countries list from the DB
    countries = Countries.list_countries()
          
    # Extract just the country and currency ids
    for c <- countries do
      [c.id, c.currency_id]
    end
  end

  def create_emp_dataset(emp_dataset, fnms, lnms, jts, sals, cdta, n) when n <= 1 do
    employee = [Enum.random(fnms),
                Enum.random(lnms),
                Enum.random(jts),
                Enum.random(sals) * 1000,
                Enum.random(cdta)]

    MapSet.put(emp_dataset, employee)
  end

  def create_emp_dataset(emp_dataset, fnms, lnms, jts, sals, cdta, n) do
    employee = [Enum.random(fnms),
                Enum.random(lnms),
                Enum.random(jts),
                Enum.random(sals) * 1000,
                Enum.random(cdta)]

    emp_dataset = MapSet.put(emp_dataset, employee)
    create_emp_dataset(emp_dataset, fnms, lnms, jts, sals, cdta, n - 1)
  end

  # def create_emp_dataset(emp_dataset, n) when n <= 1 do
  #   # employee = [Enum.random(first_names),
  #   #             Enum.random(last_names),
  #   #             Enum.random(job_titles),
  #   #             Enum.random(salaries) * 1000,
  #   #             Enum.random(country_data)]

  #   MapSet.put(emp_dataset, n)
  # end

  # def create_emp_dataset(emp_dataset, n) do
  #   # employee = [Enum.random(first_names),
  #   #             Enum.random(last_names),
  #   #             Enum.random(job_titles),
  #   #             Enum.random(salaries) * 1000,
  #   #             Enum.random(country_data)]

  #   emp_dataset = MapSet.put(emp_dataset, n)
  #   create_emp_dataset(emp_dataset, n - 1)
  # end

  # Function to generate the 10000 employee records to populate the database
  def generate_employee_data(emp_dataset, n) do
    first_names = EmployeeData.generate_first_names
    last_names = EmployeeData.generate_last_names
    job_titles = EmployeeData.generate_job_titles
    country_data = EmployeeData.generate_countries_currencies

    # List of salaries * 1000 below
    salaries = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]       
              
    # Now we needd to create 10,000 employee records by matching a 
    # first name to a last name, a random job title, a salary, and 
    # country of citizens ship.   For salary we will generate a range
    # of 10,000 to 100,000 in non-descript values

    # Use a recusrive function to select random values from the lists of employee data
    # to generate unique employee records.  Use a MapSet to filter the duplicates
    create_emp_dataset(emp_dataset, first_names, last_names, job_titles, salaries, country_data, n)
    #create_emp_dataset(emp_dataset, n)
    #IO.inspect(emp_dataset, label: "EMPMAP: ")
  end
end

# Use a Map Set to maintain unique records before adding them to the DB
emp_dataset = MapSet.new()
emp_dataset = EmployeeData.generate_employee_data(emp_dataset, 10)
IO.inspect(emp_dataset, label: "EOP DB-Data: ")

# Now generate the employee data and populate the database

