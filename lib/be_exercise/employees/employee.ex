defmodule Exercise.Employees.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :first_name, :string
    field :last_name, :string
    field :emp_id, :integer
    field :job_title, :string
    field :salary, :decimal
    field :country_id, :integer
    field :currency_id, :integer
  
    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :emp_id, :job_title, :salary, :country_id, :currency_id])
    |> validate_required([:first_name, :last_name, :emp_id, :job_title, :salary])
    |> validate_number(:emp_id, greater_than: 0)
    |> validate_number(:salary, greater_than: 0)      
    |> validate_number(:country_id, greater_than: 0)  
    |> validate_number(:currency_id, greater_than: 0) 
    |> unique_constraint(:emp_id) 
  end
end
