defmodule Exercise.Countries.Country do
  use Ecto.Schema
  import Ecto.Changeset
  
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
    |> validate_length(:code, is: 3)
    |> validate_length(:name, min: 1, max: 50)
    |> foreign_key_constraint(:currency_id)   
    |> unique_constraint(:code)
    |> unique_constraint(:name)
  end
end
