defmodule Exercise.Countries.Country do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :id, autogenerate: true}
  
  schema "countries" do
    field :code, :string
    field :name, :string
    field :currency_id, :integer

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name, :code, :currency_id])
    |> validate_required([:name, :code, :currency_id])
    |> validate_number(:currency_id, greater_than: 0)   
    |> foreign_key_constraint(:currency_id)   
    |> unique_constraint(:name)
    |> unique_constraint(:code)
  end
end
