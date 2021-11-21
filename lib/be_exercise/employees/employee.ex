defmodule Exercise.Employees.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :country_id, :integer
    field :emp_id, :integer
    field :first_name, :string
    field :last_name, :string
    field :job_title, :string
    field :salary, :decimal
   
    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:country_id, :emp_id,
                    :first_name, :last_name, 
                    :job_title, :salary])
    |> validate_required([:country_id, :emp_id,
                    :first_name, :last_name, 
                    :job_title, :salary])
    |> validate_number(:emp_id, greater_than: 0)
    |> validate_number(:salary, greater_than: 0)      
    |> validate_number(:country_id, greater_than: 0)  
    |> foreign_key_constraint(:country_id) 
    |> unique_constraint(:emp_id) 
  end
end
