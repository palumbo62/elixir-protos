defmodule Exercise.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :code, :string
      add :name, :string
      add :currency_id, references(:currencies, on_delete: :nilify_all)

      timestamps()
    end

    create unique_index(:countries, :code)
  end
end
