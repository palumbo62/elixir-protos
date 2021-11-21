defmodule Exercise.Repo.Migrations.AddEmpIdIdx do
  use Ecto.Migration

  def change do
    alter table("employees") do
      add :emp_id, :bigint
    end
    create unique_index(:employees, [:emp_id])
  end
end
