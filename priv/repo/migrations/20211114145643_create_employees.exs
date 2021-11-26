defmodule Exercise.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :job_title, :string
      add :salary, :numeric
      add :emp_id, :integer
      add :country_id, references(:countries, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:employees, [:emp_id, :last_name])
    create unique_constraint(:country_id)
  end
end
  