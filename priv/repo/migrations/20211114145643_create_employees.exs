defmodule Exercise.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :job_title, :string
      add :salary, :numeric

      add :country_id, references(:countries, on_delete: :nothing)
      add :currency_id, references(:currencies, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:employees, [:last_name])

    create index(:employees, [:country_id])
    create index(:employees, [:currency_id])

  end
end
