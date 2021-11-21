defmodule Exercise.Metrics.SalaryCountry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "salary_countries" do
    field :avg, :decimal
    field :code, :string
    field :crcode, :string
    field :max, :decimal
    field :min, :decimal

    timestamps()
  end

  @doc false
  def changeset(salary_country, attrs) do
    salary_country
    |> cast(attrs, [:min, :max, :avg, :code, :crcode])
    |> validate_required([:min, :max, :avg, :code, :crcode])
  end
end
