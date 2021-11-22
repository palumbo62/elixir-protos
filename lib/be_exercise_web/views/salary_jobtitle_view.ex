defmodule ExerciseWeb.SalaryJobtitleView do
  use ExerciseWeb, :view
  alias ExerciseWeb.SalaryJobtitleView

  def render("index.json", %{salary_jobtitles: salary_jobtitles}) do
    %{data: render_many(salary_jobtitles, SalaryJobtitleView, "salary_jobtitle.json")}
  end

  def render("show.json", %{salary_jobtitle: salary_jobtitle}) do
    %{data: render_one(salary_jobtitle, SalaryJobtitleView, "salary_jobtitle.json")}
  end

  def render("salary_jobtitle.json", %{salary_jobtitle: salary_jobtitle}) do
    %{id: salary_jobtitle.id,
      jobtitle: salary_jobtitle.jobtitle,
      avg: salary_jobtitle.avg,
      name: salary_jobtitle.name,
      symbol: salary_jobtitle.symbol}
  end
end
