defmodule ExerciseWeb.CurrencyController do
  use ExerciseWeb, :controller

  alias Exercise.Countries
  alias Exercise.Countries.Currency

  action_fallback ExerciseWeb.FallbackController

  def index(conn, _params) do
    currencies = Countries.list_currencies()
    render(conn, "index.json", currencies: currencies)
  end

  def create(conn, %{"currency" => currency_params}) do
    with {:ok, %Currency{} = currency} <- Countries.create_currency(currency_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.currency_path(conn, :show, currency))
      |> render("show.json", currency: currency)
    end
  end

  def show(conn, %{"id" => id}) do
    case Countries.get_currency(id) do
      nil -> {:error, :not_found}
      currency -> 
        render(conn, "show.json", currency: currency)
    end
  end

  def update(conn, %{"id" => id, "currency" => currency_params}) do
    case Countries.get_currency(id) do
      nil -> {:error, :not_found}
      currency ->
        with {:ok, %Currency{} = currency} 
          <- Countries.update_currency(currency, currency_params) do
          render(conn, "show.json", currency: currency)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    case Countries.get_currency(id) do
      nil -> {:error, :not_found}
      currency ->
        with {:ok, %Currency{}} 
          <- Countries.delete_currency(currency) do
            send_resp(conn, :no_content, "")
        end
    end
  end

end 
