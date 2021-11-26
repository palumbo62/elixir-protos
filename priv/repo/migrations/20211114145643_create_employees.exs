defmodule Exercise.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :job_title, :string
      add :salary, :numeric
      add :emp_id, :integer
      add :country_id, references(:countries, on_delete: :do_nothing)

      timestamps()
    end

    create unique_index(:employees, [:last_name])
    create unique_index(:employees, [:emp_id])

    create index(:employees, [:country_id])
  end
end
  