defmodule Exercise.Employees.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :first_name, :string
    field :last_name, :string
    field :job_title, :string
    field :salary, :decimal
    field :country_id, :integer
    field :currency_id, :integer
  
    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :job_title, :salary, :country_id, :currency_id])
    |> validate_required([:first_name, :last_name, :job_title, :salary])
  end
end
