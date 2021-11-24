defmodule ExerciseWeb.SalaryCountryView do
  use ExerciseWeb, :view
  alias ExerciseWeb.SalaryCountryView

  def render("index.json", %{salary_countries: salary_countries}) do
    %{data: render_many(salary_countries, SalaryCountryView, "salary_country.json")}
  end

  def render("show.json", %{salary_country: salary_country}) do
    %{data: render_many(salary_country, SalaryCountryView, "salary_country.json")}
  end

  def render("salary_country.json", %{salary_country: salary_country}) do
    %{min: Decimal.round(salary_country.min, 2),
      max: Decimal.round(salary_country.max, 2),
      avg: Decimal.round(salary_country.avg, 2),
      code: salary_country.code,
      crcode: salary_country.crcode}
  end
end
