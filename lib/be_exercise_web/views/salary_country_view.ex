defmodule ExerciseWeb.SalaryCountryView do
  use ExerciseWeb, :view
  alias ExerciseWeb.SalaryCountryView

  def render("index.json", %{salary_countries: salary_countries}) do
    IO.inspect salary_countries, label: "@@@@@ SALARIES"
    %{data: render_many(salary_countries, SalaryCountryView, "salary_country.json")}
  end

  def render("show.json", %{salary_country: salary_country}) do
    %{data: render_one(salary_country, SalaryCountryView, "salary_country.json")}
  end

  def render("salary_country.json", %{salary_country: salary_country}) do
    %{id: salary_country.id,
      min: salary_country.min,
      max: salary_country.max,
      avg: salary_country.avg,
      code: salary_country.code,
      crcode: salary_country.crcode}
  end
end
