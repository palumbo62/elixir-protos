defmodule ExerciseWeb.SalaryCountryController do
  use ExerciseWeb, :controller

  alias Exercise.Metrics

  action_fallback ExerciseWeb.FallbackController

  def index(conn, _params) do
    salary_countries = Metrics.list_salary_countries()
    render(conn, "index.json", salary_countries: salary_countries)
  end

  def show(conn, %{"id" => id}) do
    salary_country = Metrics.get_salary_country!(id)
    render(conn, "show.json", salary_country: salary_country)
  end

end
